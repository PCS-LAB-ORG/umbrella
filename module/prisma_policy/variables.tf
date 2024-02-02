variable "search_type" {
  description = "type of the search"
  type        = string
  default     = "config"
}

variable "query" {
  description = "query of the search"
  type        = string
  default     = ""
}


variable "unit" {
  description = "hour day week month year"
  type        = string
  default     = "day"
}


variable "amount" {
  description = "amount of hour/day"
  type        = string
  default     = "7"
}

variable "savedsearch_name" {
  description = "name of the saved search"
  type        = string
  default     = ""
}

variable "cloud_type" {
  description = "AWS / Azure / GCP"
  type        = string
  default     = "aws"
}


variable "policy_type" {
  description = "config / network / ... "
  type        = string
  default     = "config"
}

variable "policy_name" {
  description = "policy name"
  type        = string
  default     = ""
}

variable "rule_name" {
  description = "rule name"
  type        = string
  default     = ""
}

variable "rule_type" {
  description = "config / network / ... "
  type        = string
  default     = "Config"
}
