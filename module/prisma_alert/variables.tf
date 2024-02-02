variable "policy_name" {
  description = "policy name"
  type        = string
  default     = ""
}


variable "alert_rule_name" {
  description = "alert rule name"
  type        = string
  default     = ""
}


variable "alert_rule_description" {
  description = " Alert rule description"
  type        = string
  default     = "Made by Terraform"
}

variable "notification_config_type" {
 description = "notification config type"
  type        = string
  default     = "email"
}

variable "notification_recipients" {
 description = "notification recipients"
  type        = list(string)
  default     = [""]
}

variable "existing_account_group_name" {
 description = "existing account group name id"
  type        = string
  default     = ""
}

