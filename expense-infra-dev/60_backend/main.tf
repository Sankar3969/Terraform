module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = local.ami_id
  name = "${var.project}-${var.Environment}-${var.backend}"
  instance_type          = "t3.micro"

  vpc_security_group_ids = [local.backend_sg]
  subnet_id              = local.private_subnet
  tags = merge(
    var.common_tags,
    var.backend_tags,
    {
      Name = "${var.project}-${var.Environment}-${var.backend}"
    }
  )
}

resource "null_resource" "backend" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id =  module.backend.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.backend.private_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }

   provisioner "file" {
    source      = "${var.backend}.sh"
    destination = "/tmp/backend.sh"
  }


  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/backend.sh",
      #"sudo sh /tmp/backend.sh ${var.backend} ${var.Environment}"
      "sudo sh /tmp/backend.sh backend dev"
    ]
  }
}

resource "aws_ec2_instance_state" "backend" {
  instance_id = module.backend.id
  state       = "stopped"
  depends_on =[null_resource.backend]
}

resource "aws_ami_from_instance" "backend" {
  name               = "${var.project}-${var.Environment}-${var.backend}"
  source_instance_id = module.backend.id
  depends_on =[aws_ec2_instance_state.backend]
}

resource "null_resource" "backend_delete" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.backend.id
  }

  provisioner "local-exec" {
      environment = {
      AWS_DEFAULT_REGION = "us-east-1"
    }
    command = "aws ec2 terminate-instances --instance-ids ${module.backend.id}"
  }

  depends_on = [aws_ami_from_instance.backend]
}



resource "aws_lb_target_group" "backend" {
  name     = "${var.project}-${var.Environment}-${var.backend}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  health_check {
    healthy_threshold =2
    unhealthy_threshold =2
    interval = 5
    matcher  = "200-299"
    port     = "8080"
    path     = "/health"
    protocol = "HTTP"
    timeout  = 4
  }
}

resource "aws_launch_template" "backend" {
  name = "${var.project}-${var.Environment}-${var.backend}"
  image_id = aws_ami_from_instance.backend.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.backend_sg]
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "test"
    }
  }
}

resource "aws_autoscaling_group" "backend" {
  name                      = "${var.project}-${var.Environment}-${var.backend}"
  max_size                  = 10
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
  vpc_zone_identifier       = [local.private_subnet]
  target_group_arns = [aws_lb_target_group.backend.arn]
  launch_template {
    id      = aws_launch_template.backend.id
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
    value               = "${var.project}-${var.Environment}-${var.backend}"
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
resource "aws_autoscaling_policy" "backend" {
 
  name                   = "${var.project}-${var.Environment}-${var.backend}"
  autoscaling_group_name = aws_autoscaling_group.backend.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}


resource "aws_lb_listener_rule" "backend" {
  listener_arn = local.aws_lb_listener
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }

  condition {
    host_header {
      values = ["${var.backend}.app-${var.Environment}.${var.zone_name}"]
    }
  }
}


