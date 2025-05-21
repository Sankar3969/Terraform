module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.Project}-${var.Environment}"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "transactions"
  username = "root"
  password = "ExpenseApp1"
  port     = "3306"
  manage_master_user_password = false

  db_subnet_group_name = local.subnet_group_name

  vpc_security_group_ids = [local.db_security_grp]

  tags = merge(
    var.common_tags,
    var.database_tags,
    {
        Name = "${var.Project}-${var.Environment}-${var.database}"
    })

  skip_final_snapshot = true
  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}


module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name

  records = [
   
    {
      name    = "mysql-${var.Environment}"
      type    = "CNAME"
      ttl     = 1
      records = [
        module.db.db_instance_address
      ]
    }
  ]


}