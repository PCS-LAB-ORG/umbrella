# Module ec2_instance

This module creates an EC2 instance

## Usage

The instance can be either a public or private instance 
It can have block storage or Ephemeral storage


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami | ID of AMI to use for the instance | string | - | yes |
| associate_public_ip_address | If true, the EC2 instance will have associated public IP address | string | `false` | no |
| count | Number of instances to launch | string | `1` | no |
| disable_api_termination | If true, enables EC2 Instance Termination Protection | string | `false` | no |
| ebs_block_device | Additional EBS block devices to attach to the instance | string | `<list>` | no |
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | string | `false` | no |
| ephemeral_block_device | Customize Ephemeral (also known as Instance Store) volumes on the instance | string | `<list>` | no |
| iam_instance_profile | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | string | `` | no |
| instance_initiated_shutdown_behavior | Shutdown behavior for the instance | string | `` | no |
| instance_type | The type of instance to start | string | - | yes |
| ipv6_address_count | A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. | string | `0` | no |
| ipv6_addresses | Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface | string | `<list>` | no |
| key_name | The key name to use for the instance | string | `` | no |
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | string | `false` | no |
| name | Name to be used on all resources as prefix | string | - | yes |
| network_interface | Customize network interfaces to be attached at instance boot time | string | `<list>` | no |
| placement_group | The Placement Group to start the instance in | string | `` | no |
| private_ip | Private IP address to associate with the instance in a VPC | string | `` | no |
| root_block_device | Customize details about the root block device of the instance. See Block Devices below for details | string | `<list>` | no |
| source_dest_check | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. | string | `true` | no |
| subnet_id | The VPC Subnet ID to launch in | string | - | yes |
| tags | A mapping of tags to assign to the resource | string | `<map>` | no |
| tenancy | The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host. | string | `default` | no |
| user_data | The user data to provide when launching the instance | string | `` | no |
| volume_tags | A mapping of tags to assign to the devices created by the instance at launch time | string | `<map>` | no |
| vpc_security_group_ids | A list of security group IDs to associate with | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| availability_zone | List of availability zones of instances |
| id | List of IDs of instances |
| key_name | List of key names of instances |
| network_interface_id | List of IDs of the network interface of instances |
| primary_network_interface_id | List of IDs of the primary network interface of instances |
| private_dns | List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC |
| private_ip | List of private IP addresses assigned to the instances |
| public_dns | List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC |
| public_ip | List of public IP addresses assigned to the instances, if applicable |
| security_groups | List of associated security groups of instances |
| subnet_id | List of IDs of VPC subnets of instances |
| tags | List of tags of instances |
| vpc_security_group_ids | List of associated security groups of instances, if running in non-default VPC |

