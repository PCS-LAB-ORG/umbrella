module "variables" {
  source = "../../variables"
}
provider aws {
  region  = module.variables.region
  profile = module.variables.username
}


#Remote State
module "remote_state" {
  source                     = "../../module/remote-tfstate"
  tfstate_bucket_name        = "tfstate-bucket-umbrella-6260"
  dynamodb_name              =  "tfstate-dynamodb-umbrella-6260"
  region                     = module.variables.region
}
