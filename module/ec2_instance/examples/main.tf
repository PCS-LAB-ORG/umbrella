module "minimal" {
  source = "../"

  key_name              = var.key_name
  instance_name         = var.instance_name
  availibility_zones    = module.globals.az_list
  userdata_file         = "${path.cwd}/${var.userdata_file}"
  instance_profile_name = "Profile_name"
  aws_vpc_id            = var.aws_vpc_id
  subnet_id             = var.subnet_id
}

module "custom" {
  source = "../"

  key_name              = var.key_name
  instance_name         = var.instance_name
  availibility_zones    = module.globals.az_list
  userdata_file         = "${path.cwd}/${var.userdata_file}"
  instance_profile_name = "Profile_name"
  aws_vpc_id            = var.aws_vpc_id
  subnet_id             = var.subnet_id

  tags = var.default_tags
}

module "full" {
  source = "../"

  key_name              = var.key_name
  instance_name         = var.instance_name
  availibility_zones    = module.globals.az_list
  userdata_file         = "${path.cwd}/${var.userdata_file}"
  instance_profile_name = "Profile_name"
  aws_vpc_id            = var.aws_vpc_id
  subnet_id             = var.subnet_id

  tags                          = var.default_tags
  instance_shutdown_behavior    = "terminate"
  aws_sg_ssh_ingress_cidr_block = ["10.1.0.0/16"]
  stop_at_night                 = "true"
}
