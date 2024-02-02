module "variables" {
  source = "../../variables"
}

terraform {
	required_providers {
	aws = {
	  source  = "hashicorp/aws"
	  version = "~> 4.26.0"
	}
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }

   backend "s3" {
    bucket   = "tfstate-bucket-umbrella-6260"
    key      = "tfstate/terraform.tfstate-kub"
    region   = "us-east-1"

  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket  = "tfstate-bucket-umbrella-6260"
    key = "tfstate/terraform.tfstate-eks"
    region = "us-east-1"
  }
}




provider aws {
  region  = module.variables.region
  profile = module.variables.username
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.eks_cluster_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.terraform_remote_state.eks.outputs.eks_cluster_name
    ]
  }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.eks_cluster_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.terraform_remote_state.eks.outputs.eks_cluster_name
    ]
  }
}
}
