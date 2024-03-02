module "variables" {
  source = "../../variables"
}

provider aws {
  region  = module.variables.region
  profile = module.variables.username
}



terraform {
  backend "s3" {
    bucket = "tfstate-bucket-umbrella-6260"
    key    = "tfstate/terraform.tfstate-vpc"
    region = "us-east-1"

  }
}

#############################################################
######################   VPCs   #############################
#############################################################


#VPC
module "vpc_1" {
  source               = "../../module/vpc"
  cidr                 = module.variables.vpc_cidrs
  azs                  = module.variables.az_list
  public_subnets       = module.variables.public_subnets
  public_subnet_name   = module.variables.public_subnet_name
  public_subnet_suffix = module.variables.public_subnet_suffix
  compute              = module.variables.private_subnet_cidrs["compute"]
  database             = module.variables.private_subnet_cidrs["database"]
  short_az_list        = module.variables.short_az_list
  vpc_name             = module.variables.vpc_name

}

resource "aws_default_vpc" "default" {
  # checkov:skip=CKV_AWS_148: ADD REASON
  tags = {
    Name        = "Default VPC"
    application = "umbrella"
    yor_trace   = "182e97d7-4752-4b08-b277-3a31861c83e7"
  }

  force_destroy = true
}


module "loggroups_vpc_1" {
  source         = "../../module/cloudwatch"
  log_group_name = module.variables.log_group_name
}

resource "aws_flow_log" "prisma_flow_log" {
  iam_role_arn    = aws_iam_role.flowlog_role.arn
  log_destination = module.loggroups_vpc_1.loggroup_arn
  traffic_type    = "ALL"
  vpc_id          = module.vpc_1.vpc_id
  tags = {
    application = "umbrella"
    yor_trace   = "6579eb32-360f-41fb-8a4d-1b40eaa7e69f"
  }
}

resource "aws_iam_role" "flowlog_role" {
  name = "flowlog-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    application = "umbrella"
    yor_trace   = "c2d77b83-a75e-4ddc-8fa2-245ab59e926e"
  }
}

resource "aws_iam_role_policy" "flowlog_policy" {
  name = "flowlog"
  role = aws_iam_role.flowlog_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
