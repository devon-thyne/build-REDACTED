/*
  Filename: subnets.tf
  Synopsis: Creates the VPC subnets
  Description: Creates basic subnets in availability zones a, b, and c
  Comments: N/A
*/


##### Private subnets

resource "aws_subnet" "subnet_private_1a" {
    vpc_id            = "${ aws_vpc.vpc.id }"
    availability_zone = "${ var.aws_region }a"
    cidr_block        = "${ var.vpc_custom_octet }.1.0/24"
    map_public_ip_on_launch = "false"
    tags = {
        Name = "${ var.vpc_custom_name }-az1a-private-subnet"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
        prevent_destroy = true
    }
}

resource "aws_subnet" "subnet_private_1b" {
    vpc_id            = "${ aws_vpc.vpc.id }"
    availability_zone = "${ var.aws_region }b"
    cidr_block        = "${ var.vpc_custom_octet }.2.0/24"
    map_public_ip_on_launch = "false"
    tags = {
        Name = "${ var.vpc_custom_name }-az1b-private-subnet"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
        prevent_destroy = true
    }    
}

resource "aws_subnet" "subnet_private_1c" {
    vpc_id            = "${ aws_vpc.vpc.id }"
    availability_zone = "${ var.aws_region }c"
    cidr_block        = "${ var.vpc_custom_octet }.3.0/24"
    map_public_ip_on_launch = "false"
    tags = {
        Name = "${ var.vpc_custom_name }-az1c-private-subnet"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
        prevent_destroy = true
    }
}

