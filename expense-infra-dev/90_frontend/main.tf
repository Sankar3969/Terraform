module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = local.ami_id
  name = "${var.project}-${var.Environment}-${var.frontend}"
  instance_type          = "t3.micro"

  vpc_security_group_ids = [local.frontend_sg]
  subnet_id              = local.public_subnet
  tags = merge(
    var.common_tags,
    var.frontend_tags,
    {
      Name = "${var.project}-${var.Environment}-${var.frontend}"
    }
  )
}

resource "null_resource" "frontend" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id =  module.frontend.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.frontend.private_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }

   provisioner "file" {
    source      = "${var.frontend}.sh"
    destination = "/tmp/frontend.sh"
  }


  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/frontend.sh",
      #"sudo sh /tmp/frontend.sh ${var.frontend} ${var.Environment}"
      "sudo sh /tmp/frontend.sh frontend dev"
    ]
  }
}

resource "aws_ec2_instance_state" "frontend" {
  instance_id = module.frontend.id
  state       = "stopped"
  depends_on =[null_resource.frontend]
}

resource "aws_ami_from_instance" "frontend" {
  name               = "${var.project}-${var.Environment}-${var.frontend}"
  source_instance_id = module.frontend.id
  depends_on =[aws_ec2_instance_state.frontend]
}

resource "null_resource" "frontend_delete" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.frontend.id
  }

  provisioner "local-exec" {
      environment = {
      AWS_DEFAULT_REGION = "us-east-1"
    }
    command = "aws ec2 terminate-instances --instance-ids ${module.frontend.id}"
  }

  depends_on = [aws_ami_from_instance.frontend]
}



resource "aws_lb_target_group" "frontend" {
  name     = "${var.project}-${var.Environment}-${var.frontend}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  health_check {
    healthy_threshold =2
    unhealthy_threshold =2
    interval = 5
    matcher  = "200-299"
    port     = "80"
    path     = "/"
    protocol = "HTTP"
    timeout  = 4
  }
}

resource "aws_launch_template" "frontend" {
  name = "${var.project}-${var.Environment}-${var.frontend}"
  image_id = aws_ami_from_instance.frontend.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.frontend_sg]
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "test"
    }
  }
}

resource "aws_autoscaling_group" "frontend" {
  name                      = "${var.project}-${var.Environment}-${var.frontend}"
  max_size                  = 10
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
  vpc_zone_identifier       = [local.public_subnet]
  target_group_arns = [aws_lb_target_group.frontend.arn]
  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }
 instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  tag {
    key                 = "Name"
    value               = "${var.project}-${var.Environment}-${var.frontend}"
    propagate_at_launch = true
  }
# if instances are not healthy with in 15 m auto scaling delete that instance
  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Project"
    value               = "Expense"
    propagate_at_launch = false
  }
}
resource "aws_autoscaling_policy" "frontend" {
 
  name                   = "${var.project}-${var.Environment}-${var.frontend}"
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}


resource "aws_lb_listener_rule" "frontend" {
  listener_arn = local.web_alb_listner_https
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }

  condition {
    host_header {
      values = ["expense-${var.Environment}.${var.zone_name}"]
    }
  }
}


