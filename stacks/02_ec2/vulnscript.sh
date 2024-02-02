#! /bin/bash
#until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
#  sleep 1
#done
sudo yum update -y
sudo yum install nmap -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
sudo yum install git -y
#sudo docker pull jenkins/jenkins:2.138
#sudo docker run --name jenkins_vuln jenkins/jenkins:2.138
