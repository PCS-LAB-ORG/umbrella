module "variables" {
  source = "../../variables"
}


provider aws {
  region  = module.variables.region
  profile = module.variables.username
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-umbrella-6260"
    key    = "tfstate/terraform.tfstate-eks"
    region = "us-east-1"

  }
}


data "aws_subnet" "my_public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["public-a"]
  }
}


data "aws_subnet" "my_public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["public-b"]
  }
}

#############################################################
##################     EKS Cluster    #######################
#############################################################


resource "aws_eks_cluster" "Umbrella-EKS-Cluster" {
  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = "10.100.0.0/16"
  }

  name     = "EKS-Cluster-umbrella-6260"
  role_arn = aws_iam_role.Umbrella-AmazonEKSClusterRole.arn
  version  = "1.27"

  vpc_config {
    endpoint_private_access = "false"
    endpoint_public_access  = "true"
    public_access_cidrs     = ["0.0.0.0/0"]
    subnet_ids              = [data.aws_subnet.my_public_subnet_1.id, data.aws_subnet.my_public_subnet_2.id]
  }
  tags = {
    application = "umbrella"
    yor_trace   = "1c3138ea-1411-4c99-aefd-fea175168c4c"
  }
}

resource "aws_iam_policy" "Umbrella-eksWorkNodeEBSPolicy" {
  name = "eksWorkNodeEBSPolicy-umbrella-6260"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteSnapshot",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeInstances",
        "ec2:DescribeSnapshots",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
  tags = {
    application = "umbrella"
    yor_trace   = "8cb99ffb-a56b-42ff-ba6e-fe51af6e5470"
  }
}

resource "aws_iam_policy" "Umbrella-MongoDBPolicy" {
  name = "MongoDBPolicy-umbrella-6260"
  path = "/"

  policy = <<POLICY
{
  "Statement": [
    {
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
POLICY
  tags = {
    application = "umbrella"
    yor_trace   = "802af0a7-abbc-4dae-97ce-012f1d63bdd9"
  }
}

resource "aws_iam_role" "Umbrella-AmazonEKSNodeRole" {
  assume_role_policy = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  description          = "Allows EC2 instances to call AWS services on your behalf."
  managed_policy_arns  = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "${aws_iam_policy.Umbrella-eksWorkNodeEBSPolicy.arn}"]
  max_session_duration = "3600"
  name                 = "AmazonEKSNodeRole-umbrella-6260"
  path                 = "/"
  tags = {
    application = "umbrella"
    yor_trace   = "16d42b35-f667-4c27-b0e8-e73be159c8a4"
  }
}

resource "aws_iam_role" "Umbrella-AmazonEKSClusterRole" {
  assume_role_policy = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  description          = "Allows access to other AWS service resources that are required to operate clusters managed by EKS."
  managed_policy_arns  = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
  max_session_duration = "3600"
  name                 = "AmazonEKSClusterRole-umbrella-6260"
  path                 = "/"
  tags = {
    application = "umbrella"
    yor_trace   = "8a14cbe2-8184-4418-b16a-de10724cafb2"
  }
}

resource "aws_iam_role" "Umbrella-MongoDBRole" {
  assume_role_policy = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  description          = "Allows EC2 instances to call AWS services on your behalf."
  managed_policy_arns  = [aws_iam_policy.Umbrella-MongoDBPolicy.arn, "arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  max_session_duration = "3600"
  name                 = "MongoDBRole-umbrella-6260"
  path                 = "/"
  tags = {
    application = "umbrella"
    yor_trace   = "4a52979a-0883-49c4-8a6c-97638be357ee"
  }
}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.Umbrella-EKS-Cluster.version}/amazon-linux-2/recommended/release_version"
}


resource "aws_eks_node_group" "Umbrella-EKS-NodeGrp" {
  ami_type        = "AL2_x86_64"
  capacity_type   = "ON_DEMAND"
  cluster_name    = "${aws_eks_cluster.Umbrella-EKS-Cluster.name}"
  disk_size       = "20"
  instance_types  = ["t3.medium"]
  node_group_name = "EKS-NodeGrp-umbrella-6260"
  node_role_arn   = aws_iam_role.Umbrella-AmazonEKSNodeRole.arn
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)

  scaling_config {
    desired_size = "2"
    max_size     = "2"
    min_size     = "1"
  }

  subnet_ids = [data.aws_subnet.my_public_subnet_1.id, data.aws_subnet.my_public_subnet_2.id]

  update_config {
    max_unavailable = "1"
  }

  version = "1.27"
  tags = {
    application = "umbrella"
    yor_trace   = "e589fa46-ca09-43cb-95a5-f8c08c30ce96"
  }
}
