# Umbrella Game
This repository aims to deploy the infrastructure necessary to perform a game to learn the use of Prisma Cloud

# Umbrella Retailer
![Screenshot](umbrella.png)

# Umbrella-AWS design
![Screenshot](aws-design.png)

# Umbrella-Prisma design 
![Screenshot](prisma-design.png)

# Requirements
- 1°) Windows Env
- 2°) 1 AWS Account with Access key & secret key in ./aws  [default]
- 3°) Install Terraform + Terragrunt
- 4°) Create your own umbrella-instance.pem key in repository "02_ec2"
- 5°) In your file variables.tf ==> Modify variables "myIP" , "aws_account_id_1", "notification_recipients" with your own value.
- 6°) Create your own file prismacloud_auth.json in each Prisma_Cloud stack



# Deployement
- run powershell script rename_randomly.ps1
- terragrunt run-all apply


# Commands
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

terragrunt run-all apply

aws eks update-kubeconfig --region us-east-1 --name EKS-Cluster-umbrella-XXXX
kubectl get all


# Jenkins
Connect on port http://@ip:8080
Find password sudo su 