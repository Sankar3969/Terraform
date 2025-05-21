module "mysql_sg" {
   source          = "../../aws_sg_group"
   Environment     = var.Environment
   sg_type         = var.mysql
   sg_tags         = var.mysql_tags
   description     = var.mysql_desc
   vpc_id          = data.aws_ssm_parameter.vpc_id.value #module.vpc.vpc
}
module "backend_sg" {
   source          = "../../aws_sg_group"
   Environment     = var.Environment
   sg_type         = var.backend
   sg_tags         = var.backend_tags
   description     = var.backend_desc
   vpc_id          = data.aws_ssm_parameter.vpc_id.value #module.vpc.vpc
}
module "frontend_sg" {
   source          = "../../aws_sg_group"
   Environment     = var.Environment
   sg_type         = var.frontend
   sg_tags         = var.frontend_tags
   description     = var.front_desc
   vpc_id          = data.aws_ssm_parameter.vpc_id.value #module.vpc.vpc
}

module "bastion_sg" {
   source          = "../../aws_sg_group"
   Environment     = var.Environment
   sg_type         = var.bastion
   sg_tags         = var.bastion_tags
   description     = var.bastion_desc
   vpc_id          = data.aws_ssm_parameter.vpc_id.value #module.vpc.vpc
}

module "ansible_sg" {
   source          = "../../aws_sg_group"
   Environment     = var.Environment
   sg_type         = var.ansible
   sg_tags         = var.ansible_tags
   description     = var.ansible_desc
   vpc_id          = data.aws_ssm_parameter.vpc_id.value #module.vpc.vpc
}

module "app_alb_sg" {
   source          = "../../aws_sg_group"
   Environment     = var.Environment
   sg_type         = var.app_alb
   sg_tags         = var.app_alb_tags
   description     = var.app_alb_desc
   vpc_id          = data.aws_ssm_parameter.vpc_id.value #module.vpc.vpc
}

module "vpn_sg" {
   source          = "../../aws_sg_group"
   Environment     = var.Environment
   sg_type         = var.vpn
   sg_tags         = var.vpn_tags
   description     = var.vpn_desc
   vpc_id          = data.aws_ssm_parameter.vpc_id.value #module.vpc.vpc
}

module "web_alb_sg" {
   source          = "../../aws_sg_group"
   Environment     = var.Environment
   sg_type         = var.web_alb
   sg_tags         = var.web_tags
   description     = var.web_desc
   vpc_id          = data.aws_ssm_parameter.vpc_id.value #module.vpc.vpc
}


# [True]This rule allow the mysql sg to backend  source and connection that are attached to the backend SG
# [True]
resource "aws_security_group_rule" "mysql_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend_sg.id
  security_group_id = module.mysql_sg.id
}

# This rule allow the backend sg to backend  source and connection that are attached to the frontend SG
#[false beacause backend should accept request from backend load balancer(8080) and from bastion 22  ]
# resource "aws_security_group_rule" "backend_frontend" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   source_security_group_id = module.frontend_sg.id
#   security_group_id = module.backend_sg.id
# }

# This rule allow the backend sg to backend  source and connection that are attached to the frontend SG
#[false beacause frontend should accept request from frontend load balancer(80) and from bastion 22  ]
# resource "aws_security_group_rule" "frontend_public" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#  cidr_blocks        = ["0.0.0.0/0"]
#   security_group_id = module.frontend_sg.id
# }


# This rule allow the bastion sg to mysql   source and connection that are attached to the bastion SG
#[false beacause mysql RDS  should accept request  from bastion 3306 ]
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.mysql_sg.id
}

# This rule allow the backend sg to backend  source and connection that are attached to the frontend SG
# [true] backend connected to bastion 22 and 8080
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.backend_sg.id
}

# This rule allow the backend sg to backend  source and connection that are attached to the frontend SG
# [true] fronend connected to bastion 22 and 8080
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.frontend_sg.id
}

# This rule allow the ansible sg to public  source and connection that are attached to the public SG
resource "aws_security_group_rule" "public_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.id
}


# This rule allow the ansible sg to mysql   source and connection that are attached to the ansible SG
# [false rds only connected through 3306]
# resource "aws_security_group_rule" "mysql_ansible" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.ansible_sg.id
#   security_group_id = module.mysql_sg.id
# }

# This rule allow the ansible sg to backend  source and connection that are attached to the backend SG
resource "aws_security_group_rule" "backend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id = module.backend_sg.id
}

# This rule allow the ansible sg to frontend  source and connection that are attached to the frontend SG
resource "aws_security_group_rule" "frontend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id = module.frontend_sg.id
}
# This rule allow the ansible sg to public  source and connection that are attached to the public SG
resource "aws_security_group_rule" "public_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ansible_sg.id
}


# This rule allow the app_lb sg to backend  source and connection that are attached to the backend SG
resource "aws_security_group_rule" "App_lb_backend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.id
  security_group_id = module.backend_sg.id
}

# This rule allow the app_lb sg to backend  source and connection that are attached to the backend SG
resource "aws_security_group_rule" "App_lb-bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.app_alb_sg.id
}

# vpn sg rules
# This rule allow the vpn sg to public  source and connection that are attached to the public SG
resource "aws_security_group_rule" "vpn_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.id
}
# for port 443
resource "aws_security_group_rule" "vpn_public_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.id
}
# for port 443
resource "aws_security_group_rule" "vpn_public_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.id
}
# for port 1194
resource "aws_security_group_rule" "vpn_public_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.id
}
# This rule allow the vpn sg to backend  source and connection that are attached to the vpn SG
resource "aws_security_group_rule" "App_lb-vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id = module.app_alb_sg.id
}
# This rule allow the vpn_8080 sg to backend  source and connection that are attached to the backend SG
resource "aws_security_group_rule" "backend_vpn_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id = module.backend_sg.id
}
# This rule allow the vpn_22 sg to backend  source and connection that are attached to the backend SG
resource "aws_security_group_rule" "backend_vpn_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id = module.backend_sg.id
}

# This rule allow the web_lb sg to backend  source and connection that are attached to the public SG
resource "aws_security_group_rule" "web_alb_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg.id
}
# This rule allow the web_lb sg to backend  source and connection that are attached to the public SG
resource "aws_security_group_rule" "web_alb_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg.id
}

# This rule allow the frontend sg to   source and connection that are attached to the frontend SG
resource "aws_security_group_rule" "web_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_alb_sg.id
  security_group_id = module.frontend_sg.id
}
# This rule allow the web http sg to   source and connection that are attached to the frontend SG
resource "aws_security_group_rule" "web_alb_frontend_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.web_alb_sg.id
  security_group_id = module.frontend_sg.id
}


# This rule allow the web frontend sg to   source and connection that are attached to the App-alb SG
resource "aws_security_group_rule" "frontend_backend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend_sg.id
  security_group_id = module.app_alb_sg.id
}
# This rule allow the vpn_22 sg to frontend  source and connection that are attached to the frontend SG
resource "aws_security_group_rule" "frontend_vpn_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id = module.frontend_sg.id
}