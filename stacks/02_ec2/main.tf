module "variables" {
  source = "../../variables"
}


provider aws {
  region  = module.variables.region
  profile = module.variables.username
}

terraform {
  backend "s3" {
    bucket   = "tfstate-bucket-umbrella-6260"
    key      = "tfstate/terraform.tfstate-ec2"
    region   = "us-east-1"

  }
}

#############################################################
##################     DataSource     #######################
#############################################################

data "aws_vpc" "myVPC" {
  filter {
    name = "tag:Name"
    values = [module.variables.vpc_name]
  }
}

data "aws_subnet" "my_public_subnet_1" {
  filter {
    name = "tag:Name"
    values = ["public-a"]
  }
}


data "aws_subnet" "my_public_subnet_2" {
  filter {
    name = "tag:Name"
    values = ["public-b"]
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../01_vpc/.terraform/terraform.tfstate"
  }
}

#############################################################
##################     Instance     #########################
#############################################################

# Create the Key Pair

resource "tls_private_key" "instance" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "instance" {
  key_name   = module.variables.key_name  
  public_key = "${tls_private_key.instance.public_key_openssh}"
}
# Save file
resource "local_file" "ssh_key" {
  filename = module.variables.filename
  content  = tls_private_key.instance.private_key_pem
}

locals {
  ports_in = [
    443,
    22
  ]
  ports_out = [
    0
  ]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls_ssh"
  description = "Allow TLS & SSH inbound traffic"
  vpc_id      = data.aws_vpc.myVPC.id
  
   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.variables.myIP,module.variables.public_subnets[0],module.variables.public_subnets[1]]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.variables.myIP,module.variables.public_subnets[0],module.variables.public_subnets[1]]
  }

   ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [module.variables.myIP,module.variables.public_subnets[0],module.variables.public_subnets[1]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  }

#Instance 1 
module "instance_1" {
  source = "../../module/ec2_instance"
  name                        = "Instance1"
  ami_filter                  =  "amzn2-ami-kernel-5.10-hvm-*"
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.my_public_subnet_1.id
  key_name                    = aws_key_pair.instance.key_name
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  user_data = file("./script.sh")
  private_ip                  = "10.0.0.11"

}

#Instance 2
module "instance_2" {
  source = "../../module/ec2_instance"
  name                        = "Instance2"
  ami_filter                  = "amzn2-ami-kernel-5.10-hvm-*"
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.my_public_subnet_2.id
  key_name                    = aws_key_pair.instance.key_name
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  user_data = file("./vulnscript.sh")
  private_ip                  = "10.0.1.12"

}


#Instance 3
data "template_file" "user-data-file" {
  template = "${file("${path.module}/user-data-instance3")}"

}

module "instance_3" {
  source = "../../module/ec2_instance"
  name                        = "Instance3-mongoDbServer"
  ami_filter                  = "amzn2-ami-kernel-5.10-hvm-*"
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.my_public_subnet_1.id
  key_name                    = aws_key_pair.instance.key_name
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  private_ip                  = "10.0.0.13"
  user_data                   =  "${data.template_file.user-data-file.rendered}"

}


#Instance 4 Jenkins


resource "aws_security_group" "jenkins-sg" {
  vpc_id      = data.aws_vpc.myVPC.id
  name        = "jenkins-sg"
  description = "inbound ports for ssh and standard http and everything outbound"
  dynamic "ingress" {
    for_each = [8080, 22]
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"      = "jenkins-sg"
    "Terraform" = "true"
  }
}




resource "aws_instance" "jenkins" {
  ami             = "ami-061dc0582f86ee66b"
 
  instance_type   = "t2.micro"
  subnet_id = data.aws_subnet.my_public_subnet_1.id
  vpc_security_group_ids  = [aws_security_group.jenkins-sg.id]
  key_name        = aws_key_pair.instance.key_name
  provisioner "remote-exec" {
    inline = [
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee  /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee  /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt update",
      "sudo apt install openjdk-11-jre -y",
      "sudo apt-get install jenkins -y",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("umbrella-instance.pem")
    agent = false

  }
  tags = {
    "Name" = "Jenkins"
  }
}
