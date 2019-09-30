/*
  Filename: outputs.tf
  Synopsis: Outputs of the Module
  Description: Output commonly used values of the VPC
  Comments: N/A
*/


##### VPC

output "vpc_name" { value = "${ aws_vpc.vpc.tags.Name }" }
output "vpc_id" { value = "${ aws_vpc.vpc.id }" }



##### Subnets

output "subnet_private_1a_name" { value = "${ aws_subnet.subnet_private_1a.tags.Name }" }
output "subnet_private_1a_id" { value = "${ aws_subnet.subnet_private_1a.id }" }
output "subnet_private_1b_name" { value = "${ aws_subnet.subnet_private_1b.tags.Name }" }
output "subnet_private_1b_id" { value = "${ aws_subnet.subnet_private_1b.id }" }
output "subnet_private_1c_name" { value = "${ aws_subnet.subnet_private_1c.tags.Name }" }
output "subnet_private_1c_id" { value = "${ aws_subnet.subnet_private_1c.id }" }



##### Security Groups

output "sg_egress_id" { value = "${ aws_security_group.security_group_egress.id }" }
output "sg_access-REDACTED_id" { value = "${ aws_security_group.security_group_access_REDACTED.id }" }
output "sg_vpc_id" { value = "${ aws_security_group.security_group_vpc.id }" }



##### Gateways

output "igw_id" { value = "${ aws_internet_gateway.internet_gateway.id }" }



###### Directory Service

#output "Directory_Service_Tag_Name" { value = "${ aws_directory_service_directory.directory_service.tags.Name }" }
output "Directory_Service_FQDN" { value = "${ aws_directory_service_directory.directory_service.name }" }
output "Directory_Service_NetBios" { value = "${ aws_directory_service_directory.directory_service.short_name }" }
output "Directory_Service_ID" { value = "${ aws_directory_service_directory.directory_service.id }" }
output "Directory_Service_DNS" { value = "${ aws_directory_service_directory.directory_service.dns_ip_addresses }" }

##### Instances

output "instance_awx" { value = "${ module.instance_awx }" }
output "instance_concourse" { value = "${ module.instance_concourse }" }
output "instance_nessus" { value = "${ module.instance_nessus }" }
output "instance_cron" { value = "${ module.instance_cron }" }
output "instance_vault" { value = "${ module.instance_vault }" }
output "instance_patch_green6_10" { value = "${ aws_instance.instance_patch_green6_10 }" }
output "instance_patch_green7_6" { value = "${ aws_instance.instance_patch_green7_6 }" }

