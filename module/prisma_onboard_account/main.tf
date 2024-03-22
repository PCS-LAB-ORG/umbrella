data "prismacloud_account_supported_features" "prismacloud_supported_features" {
  cloud_type   = "aws"
  account_type = "account"
}

output "features_supported" {
  value = data.prismacloud_account_supported_features.prismacloud_supported_features.supported_features
}

data "prismacloud_aws_cft_generator" "prismacloud_account_cft" {
  account_type = "account"
  account_id   = var.aws_account_id
  features     = data.prismacloud_account_supported_features.prismacloud_supported_features.supported_features
}

output "s3_presigned_cft_url" {
  value = data.prismacloud_aws_cft_generator.prismacloud_account_cft.s3_presigned_cft_url
}

resource "aws_cloudformation_stack" "prismacloud_iam_role_stack" {
  name         = "PrismaCloudApp" // change if needed
  capabilities = ["CAPABILITY_NAMED_IAM"]
  #   parameters { // optional
  #     PrismaCloudRoleName="" 
  #   }
  template_url = data.prismacloud_aws_cft_generator.prismacloud_account_cft.s3_presigned_cft_url
  tags = {
    application = "umbrella"
    yor_trace   = "ffce0024-9f78-4a02-8a29-cdbc81263977"
  }
}

output "iam_role" {
  value = aws_cloudformation_stack.prismacloud_iam_role_stack.outputs.PrismaCloudRoleARN
}



resource "prismacloud_cloud_account_v2" "aws_account_onboarding" {
  disable_on_destroy = true
  aws {
    name       = var.name // should be unique for each account
    account_id = var.aws_account_id
    group_ids = [
      data.prismacloud_account_group.existing_account_group_id.group_id, // To use existing Account Group
      //prismacloud_account_group.new_account_group.group_id, // To create new Account group
    ]
    role_arn = "${aws_cloudformation_stack.prismacloud_iam_role_stack.outputs.PrismaCloudRoleARN}" // IAM role arn from step 3
    features {                                                                                     // feature names from step 1
      name  = "Remediation"                                                                        // To enable Remediation also known as Monitor and Protect
      state = "enabled"
    }
    features {
      name  = "Agentless Scanning" // To enable 'Agentless Scanning' feature if required.
      state = "enabled"
    }
  }
}

// Retrive existing account group name id
data "prismacloud_account_group" "existing_account_group_id" {
  name = var.existing_account_group_name // Change the account group name, if you already have an account group that you wish to map the account. 
}

// To create a new account group, if required
// resource "prismacloud_account_group" "new_account_group" {
//     name = var.new_account_group_name // Account group name to be creatd
// }