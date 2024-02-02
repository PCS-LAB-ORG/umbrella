# remote_state {
#   backend = "s3"
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite"
#   }
#   config = {
#     bucket         = get_env("BucketName")
#     key            = "tfstate/terraform.tfstate-umbrella-project"
#     region         = "us-east-1"
#     dynamodb_table = get_env("DynamoDBName")
#   }
# }

