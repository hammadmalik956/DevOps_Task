module "vpc" {
  source                 = "./modules/vpc"
  name                   = "${var.vpc.name}-${terraform.workspace}"
  cidr                   = var.vpc.cidr
  azs                    = var.vpc.azs
  private_subnets        = var.vpc.private_subnets
  public_subnets         = var.vpc.public_subnets
  enable_nat_gateway     = var.vpc.enable_nat_gateway
  single_nat_gateway     = var.vpc.single_nat_gateway
  one_nat_gateway_per_az = var.vpc.one_nat_gateway_per_az
}


module "ec2_sg" {
  source     = "./modules/security_groups"
  identifier = "${var.project_name}-sg"
  vpc_id     = module.vpc.vpc_id
  ingress_rule_list = [
    {
      source_security_group_id = null
      cidr_blocks              = [var.my_public_ip]
      description              = "Allow inbound traffic"
      from_port                = 22
      protocol                 = "tcp"
      to_port                  = 22
    },
       {
      source_security_group_id = null
      cidr_blocks              = [var.my_public_ip]
      description              = "Allow inbound traffic"
      from_port                = 3306
      protocol                 = "tcp"
      to_port                  = 3306
    },
    {
      source_security_group_id = module.public-alb-sg.id
      cidr_blocks              = null
      description              = "Allow inbound HTTP traffic from ALB"
      from_port                = 80
      protocol                 = "tcp"
      to_port                  = 80
    }
  
  ]
  egress_rule_list = [
    {
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      description              = "Allow outbound traffic"
      from_port                = 0
      protocol                 = "tcp"
      to_port                  = 65535
    }
  ]
}

module "key" {
  source = "./modules/key"
}

locals {
  ec2_config = {
    ami = data.aws_ami.ubuntu_ami.id
    cpu = var.ec2_config.cpu
    associate_public_ip_address = var.ec2_config.associate_public_ip_address
  }
}
locals {
   db_conn_ssm              = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.mysql_rds.secret_string))
   rds_host =  local.db_conn_ssm.DB_HOST
}

resource "local_file" "env_file" {
  content  = templatefile("${path.module}/env_file.tpl", {
    hostname = module.ec2.ec2_instance_dns
    username = local.db_conn_ssm.DB_USER
    password = local.db_conn_ssm.DB_PASSWORD
    dbname   = local.db_conn_ssm.DB_NAME
    port     = local.db_conn_ssm.DB_PORT
    ldns     = module.public_alb.output.dns
  })
  filename = "${path.module}/../secrets.env"
}
module "ec2" {
  source       = "./modules/ec2"
  project_name = var.project_name
  key_name     = module.key.key_name #"hammad-key"
  ec2_config   = local.ec2_config
  ec2_sg_id    = module.ec2_sg.id
  subnet_id    = module.vpc.public_subnets[1]
  rds_host    = local.rds_host
  depends_on = [ module.mysql_rds ]
}


module "public-alb-sg" {
  source     = "./modules/security_groups"
  identifier = "${var.project_name}-lb-sg"
  vpc_id     = module.vpc.vpc_id
  ingress_rule_list = [
    {
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      description              = "Allow inbound traffic"
      from_port                = 80
      protocol                 = "tcp"
      to_port                  = 80
    },
    {
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      description              = "Allow inbound traffic"
      from_port                = 443
      protocol                 = "tcp"
      to_port                  = 443
    },
  ]
  egress_rule_list = [
    {
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      description              = "Allow outbound traffic"
      from_port                = 0
      protocol                 = "tcp"
      to_port                  = 65535
    }
  ]
}

module "public_alb" {
  source     = "./modules/load_balancer"
  vpc_id     = module.vpc.vpc_id
  lb_conf    = var.public_alb_conf
  subnet_ids = module.vpc.public_subnets
  sg_id      = [module.public-alb-sg.id]
  
}

resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = module.public_alb.output.tg_arn
  target_id        = module.ec2.ec2_instance_id
  port             = var.public_alb_conf.port
}


module "rds-sg" {
  source     = "./modules/security_groups"
  identifier = "${var.project_name}-rds-sg"
  vpc_id     = module.vpc.vpc_id
  ingress_rule_list = [
    {
      source_security_group_id = module.ec2_sg.id
      cidr_blocks              = null
      description              = "Allow inbound traffic"
      from_port                = 3306
      protocol                 = "tcp"
      to_port                  = 3306
    },

  ]
  egress_rule_list = [
    {
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      description              = "Allow outbound traffic"
      from_port                = 0
      protocol                 = "tcp"
      to_port                  = 65535
    }
  ]
}
module "mysql_rds" {
  source                = "./modules/rds"
  rds_allocated_storage = 20
  rds_engine_version    = var.rds.engine_version
  rds_instance_class    = var.rds.instance_class
  rds_database_name     = var.rds.db_name
  rds_master_username   = var.rds.db_user
  security_groups       = [module.rds-sg.id]
  identifier            = var.rds.identifier
  subnets               = module.vpc.private_subnets
  vpc_id                = module.vpc.vpc_id
  engine                = var.rds.engine
  family                = var.rds.param_group_family
}



