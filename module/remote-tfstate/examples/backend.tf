terraform {
  required_version = ">= 0.12."
  backend "s3" {
    region         = "eu-west-3"
    session_name   = "terraform_session"
    role_arn       = "arn:aws:iam::123456789012:role/terraform_role"
    bucket         = "<client_name>-terraform-tfstate-bucket"
    key            = "<client_name>/mtr/prd/<bundle_name>/terraform.tfstate"
    dynamodb_table = "<CLIENT_NAME>_TERRAFORM_TFSTATE_DYNAMODB"
    encrypt        = true
  }
}