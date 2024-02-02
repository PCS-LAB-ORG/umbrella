
#############################################################
###############   Instances @IP to fill #####################
#############################################################


variable "myIP" {
  description = "myIP"
  type        = string
  default     = "52.47.138.194/32"
}

output "myIP" {
  value = var.myIP
}


#############################################################
###############   Prisma To fill      #######################
#############################################################

#######   Account ID 1     ########


variable "aws_account_id_1" {
  type = string
  default = "541734770507"
}
output "aws_account_id_1" {
  value = var.aws_account_id_1
}

#######   Alert notification Email     ########

variable "notification_recipients" {
  type = list(string)
  default =  ["mdalbes@paloaltonetworks.com"]
}
output "notification_recipients" {
  value = var.notification_recipients

}










#############################################################
####################  provider  #############################
#############################################################


variable "region" {
  type = string
  default = "us-east-1"
}
output "region" {
  value = var.region
}

variable "username" {
  type = string
  default = "default"
}
output "username" {
  value = var.username
}


#############################################################
####################   Instances   ##########################
#############################################################

variable "key_name" {
  description = "Name of the Instance keyname"
  type        = string
  default     = "umbrella-instance"
}

output "key_name" {
  value = var.key_name
}



variable "filename" {
  description = "pem Path"
  type        = string
  default     = ".\\.\\umbrella-instance.pem"
}

output "filename" {
  value = var.filename
}



#############################################################
######################   VPC   ##############################
#############################################################

variable "vpc_cidrs" {
  type = string
  default = "10.0.0.0/16"   
  }


output "vpc_cidrs" {
  value = var.vpc_cidrs
}
variable "vpc_name" {
  type = string
  default = "umbrella_vpc"   
  }


output "vpc_name" {
  value = var.vpc_name
}
 
variable "az_list" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}


output "az_list" {
  value = var.az_list
}

variable "short_az_list" {
  type    = list(string)
  default = ["a","b"]
}

output "short_az_list" {
  value = var.short_az_list
}

variable "log_group_name" {
  type    = string
  default = "vpc01_loggroups"
}

output "log_group_name" {
  value = var.log_group_name
}





#############################################################
####################   SUBNETS   ############################
#############################################################

variable "private_subnet_cidrs" {
  type = map
  default = {
    compute = ["10.0.2.0/24", "10.0.3.0/24"]  
    database  = ["10.0.4.0/24", "10.0.5.0/24"]
  }
}

output "private_subnet_cidrs" {
  value = var.private_subnet_cidrs
}

variable "public_subnets" {
  type = list(string)
  default = ["10.0.0.0/24","10.0.1.0/24"]
}

output "public_subnets" {
  value = var.public_subnets
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}

output "public_subnet_suffix" {
  value = var.public_subnet_suffix
}

variable "public_subnet_name" {
  description = "Name to append to public subnets name"
  type        = string
  default     = ""
}

output "public_subnet_name" {
  value = var.public_subnet_name
}



#############################################################
####################   Prisma    ############################
#############################################################





variable "existing_account_group_name_1" {
  type = string
  default = "umbrella-acg-lab-1"
}


output "existing_account_group_name_1" {
  value = var.existing_account_group_name_1
}


#######   Policy 1     ########


variable "search_type_1" {
  type = string
  default = "config"
}
output "search_type_1" {
  value = var.search_type_1
}

variable "unit_1" {
  type = string
  default = "day"
}
output "unit_1" {
  value = var.unit_1

}

variable "amount_1" {
  type = string
  default = "7"
}
output "amount_1" {
  value = var.amount_1

}

variable "policy_type_1" {
  type = string
  default = "config"
}
output "policy_type_1" {
  value = var.policy_type_1

}

variable "rule_type_1" {
  type = string
  default = "Config"
}
output "rule_type_1" {
  value = var.rule_type_1

}


#######   Alert 1     ########


variable "notification_config_type" {
  type = string
  default =  "email"
}
output "notification_config_type" {
  value = var.notification_config_type

}

