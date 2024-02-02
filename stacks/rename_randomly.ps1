############ Variables ############

$randomNumber = Get-Random -Minimum 1000 -Maximum 9999
$bucket = "tfstate-bucket-umbrella-$randomNumber"
$DynamoDBName = "tfstate-dynamodb-umbrella-$randomNumber"
$find = 'umbrella-0000'
$replace = "umbrella-${randomNumber}"


############ Define Env-variable ############
$env:BucketName = $bucket
$env:DynamoDBName = $DynamoDBName

############ Config RemoteState   ############

$config00RemoteState = '.\00_remote_state\template-main'
$NewFileConfig00RemoteState = '.\00_remote_state\main.tf'
Get-Item -Path $config00RemoteState
Copy-Item -Path $config00RemoteState -Destination $NewFileConfig00RemoteState
(Get-Content $NewFileConfig00RemoteState).replace($find, $replace) | Set-Content $NewFileConfig00RemoteState


############ Config VPC01 ############
$config01Vpc = '.\01_vpc\template-main'
$NewFile01Vpc = '.\01_vpc\main.tf'

Get-Item -Path $config01Vpc
Copy-Item -Path $config01Vpc -Destination $NewFile01Vpc
(Get-Content $NewFile01Vpc).replace($find, $replace) | Set-Content $NewFile01Vpc

############ Config EC02 + Userdata  ############

$TemplateFileUserData02EC2 = '.\02_ec2\user-data-instance3-template'
$NewFileUserData02EC2 = '.\02_ec2\user-data-instance3'
Get-Item -Path $TemplateFileUserData02EC2
Copy-Item -Path $TemplateFileUserData02EC2 -Destination $NewFileUserData02EC2
(Get-Content $NewFileUserData02EC2).replace($find, $replace) | Set-Content $NewFileUserData02EC2


$config02EC2 = '.\02_ec2\template-main'
$NewFileConfig02EC2 = '.\02_ec2\main.tf'
Get-Item -Path $config02EC2
Copy-Item -Path $config02EC2 -Destination $NewFileConfig02EC2
(Get-Content $NewFileConfig02EC2).replace($find, $replace) | Set-Content $NewFileConfig02EC2

############ Config EKS   ############

$config03EKSCluster = '.\03_eks_cluster\template-main'
$NewFileConfig03EKSCluster = '.\03_eks_cluster\main.tf'
Get-Item -Path $config03EKSCluster
Copy-Item -Path $config03EKSCluster -Destination $NewFileConfig03EKSCluster
(Get-Content $NewFileConfig03EKSCluster).replace($find, $replace) | Set-Content $NewFileConfig03EKSCluster

############ Config Kubernetes   ############


$config04Kubernetes = '.\04_kubernetes\template-main'
$NewFileConfig04Kubernetes = '.\04_kubernetes\provider.tf'
Get-Item -Path $config04Kubernetes
Copy-Item -Path $config04Kubernetes -Destination $NewFileConfig04Kubernetes
(Get-Content $NewFileConfig04Kubernetes).replace($find, $replace) | Set-Content $NewFileConfig04Kubernetes


############ Config Prisma onboard account   ############


$config13PrismaOnboardAccount = '.\13_prisma_onboard_account\template-main'
$NewFileConfig13PrismaOnboardAccount = '.\13_prisma_onboard_account\main.tf'
Get-Item -Path $config13PrismaOnboardAccount
Copy-Item -Path $config13PrismaOnboardAccount -Destination $NewFileConfig13PrismaOnboardAccount
(Get-Content $NewFileConfig13PrismaOnboardAccount).replace($find, $replace) | Set-Content $NewFileConfig13PrismaOnboardAccount


############ Config Prisma New policy   ############


$config14PrismaNewPolicy = '.\14_prisma_new_policy\template-main'
$NewFileConfig14PrismaNewPolicy = '.\14_prisma_new_policy\main.tf'
Get-Item -Path $config14PrismaNewPolicy
Copy-Item -Path $config14PrismaNewPolicy -Destination $NewFileConfig14PrismaNewPolicy
(Get-Content $NewFileConfig14PrismaNewPolicy).replace($find, $replace) | Set-Content $NewFileConfig14PrismaNewPolicy

############ Config Prisma Alert Rule   ############


$config15PrismaAlertRule = '.\15_prisma_alert_rule\template-main'
$NewFileConfig15PrismaAlertRule = '.\15_prisma_alert_rule\main.tf'
Get-Item -Path $config15PrismaAlertRule
Copy-Item -Path $config15PrismaAlertRule -Destination $NewFileConfig15PrismaAlertRule
(Get-Content $NewFileConfig15PrismaAlertRule).replace($find, $replace) | Set-Content $NewFileConfig15PrismaAlertRule




############ Clean TFstate  ############
If (Test-Path .\00_remote_state\.terraform.lock.hcl) {
Remove-Item -Path .\00_remote_state\.terraform.lock.hcl
}

If (Test-Path .\00_remote_state\terraform.tfstate) {
Remove-Item -Path .\00_remote_state\terraform.tfstate
}

If (Test-Path .\00_remote_state\terraform.tfstate.backup) {
Remove-Item -Path .\00_remote_state\terraform.tfstate.backup
}

If (Test-Path .\00_remote_state\.terraform) {
Remove-Item -Recurse -Force  .\00_remote_state\.terraform
}

#__________________________________________________________________

If (Test-Path .\01_vpc\.terraform.lock.hcl) {
Remove-Item -Path .\01_vpc\.terraform.lock.hcl
}

If (Test-Path .\01_vpc\terraform.tfstate) {
Remove-Item -Path .\01_vpc\terraform.tfstate
}

If (Test-Path .\01_vpc\terraform.tfstate.backup) {
Remove-Item -Path .\01_vpc\terraform.tfstate.backup
}

If (Test-Path .\01_vpc\.terraform) {
Remove-Item -Recurse -Force .\01_vpc\.terraform
}

#__________________________________________________________________

If (Test-Path .\02_ec2\.terraform.lock.hcl) {
Remove-Item -Path .\02_ec2\.terraform.lock.hcl
}

If (Test-Path .\02_ec2\terraform.tfstate) {
Remove-Item -Path .\02_ec2\terraform.tfstate
}

If (Test-Path .\02_ec2\terraform.tfstate.backup) {
Remove-Item -Path .\02_ec2\terraform.tfstate.backup
}

If (Test-Path .\02_ec2\.terraform) {
Remove-Item -Recurse -Force .\02_ec2\.terraform
}
#__________________________________________________________________

If (Test-Path .\03_eks_cluster\.terraform.lock.hcl) {
Remove-Item -Path .\03_eks_cluster\.terraform.lock.hcl
}

If (Test-Path .\03_eks_cluster\terraform.tfstate) {
Remove-Item -Path .\03_eks_cluster\terraform.tfstate
}

If (Test-Path .\03_eks_cluster\terraform.tfstate.backup) {
Remove-Item -Path .\03_eks_cluster\terraform.tfstate.backup
}

If (Test-Path .\03_eks_cluster\.terraform) {
Remove-Item -Recurse -Force .\03_eks_cluster\.terraform
}
#__________________________________________________________________

If (Test-Path .\04_kubernetes\.terraform.lock.hcl) {
Remove-Item -Path .\04_kubernetes\.terraform.lock.hcl}

If (Test-Path .\04_kubernetes\terraform.tfstate) {
Remove-Item -Path .\04_kubernetes\terraform.tfstate
}

If (Test-Path .\04_kubernetes\terraform.tfstate.backup) {
Remove-Item -Path .\04_kubernetes\terraform.tfstate.backup
}

If (Test-Path .\04_kubernetes\.terraform) {
Remove-Item -Recurse -Force .\04_kubernetes\.terraform
}
#__________________________________________________________________


If (Test-Path .\13_prisma_onboard_account\.terraform.lock.hcl) {
Remove-Item -Path .\13_prisma_onboard_account\.terraform.lock.hcl
}

If (Test-Path .\13_prisma_onboard_account\terraform.tfstate) {
Remove-Item -Path .\13_prisma_onboard_account\terraform.tfstate
}

If (Test-Path .\13_prisma_onboard_account\terraform.tfstate.backup) {
Remove-Item -Path .\13_prisma_onboard_account\terraform.tfstate.backup
}

If (Test-Path .\13_prisma_onboard_account\.terraform) {
Remove-Item -Recurse -Force .\13_prisma_onboard_account\.terraform
}
#__________________________________________________________________

If (Test-Path .\14_prisma_new_policy\.terraform.lock.hcl) {
Remove-Item -Path .\14_prisma_new_policy\.terraform.lock.hcl
}

If (Test-Path .\14_prisma_new_policy\terraform.tfstate) {
Remove-Item -Path .\14_prisma_new_policy\terraform.tfstate
}

If (Test-Path .\14_prisma_new_policy\terraform.tfstate.backup) {
Remove-Item -Path .\14_prisma_new_policy\terraform.tfstate.backup
}

If (Test-Path .\14_prisma_new_policy\.terraform) {
Remove-Item -Recurse -Force .\14_prisma_new_policy\.terraform
}
#__________________________________________________________________

If (Test-Path .\15_prisma_alert_rule\.terraform.lock.hcl) {
Remove-Item -Path .\15_prisma_alert_rule\.terraform.lock.hcl
}

If (Test-Path .\15_prisma_alert_rule\terraform.tfstate) {
Remove-Item -Path .\15_prisma_alert_rule\terraform.tfstate
}

If (Test-Path .\15_prisma_alert_rule\terraform.tfstate.backup) {
Remove-Item -Path .\15_prisma_alert_rule\terraform.tfstate.backup
}

If (Test-Path .\15_prisma_alert_rule\.terraform) {
Remove-Item -Recurse -Force .\15_prisma_alert_rule\.terraform}
#__________________________________________________________________