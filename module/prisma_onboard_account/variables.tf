variable "name" {
  description = "Name to be used on Prisma UI for account name"
  type        = string
  default     = "myAwsAccountName"
}

variable "aws_account_id" {
  description = "Account ID onboarded"
  type        = string
  default     = ""
}


variable "existing_account_group_name" {
  description = "Existing Account group Name"
  type        = string
  default     = "Default Account Group"
}


variable "new_account_group_name" {
  description = "New Account group Name"
  type        = string
  default     = "Default Account Group"
}

