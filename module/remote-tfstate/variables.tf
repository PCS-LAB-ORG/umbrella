variable "tfstate_bucket_name" {
  type        = string
  description = "Name of the s3 bucket for tfstate"
}

variable "dynamodb_name" {
  type        = string
  description = "Name of the dynamodb for tfstate"
}

variable "region" {
  type        = string
  description = "Region to deploy"
}


variable "read_capacity" {
  type        = string
  default     = 1
  description = "DynamoDB read capacity units"
}

variable "write_capacity" {
  type        = string
  default     = 1
  description = "DynamoDB write capacity units"
}

variable "force_destroy" {
  type        = string
  description = "A boolean that indicates the S3 bucket can be destroyed even if it contains objects. These objects are not recoverable"
  default     = false
}

variable "block_public_acls" {
  type        = string
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  default     = true
}

variable "ignore_public_acls" {
  type        = string
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = true
}

variable "block_public_policy" {
  type        = string
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  default     = true
}

variable "restrict_public_buckets" {
  type        = string
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  default     = true
}

variable "regex_replace_chars" {
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "S3 algorithm"
}


variable "dynamo_db_encryption" {
  description = "Enable DynamoDB encryption"
  default     = true
  type        = string
}



