/*
  Filename: securitygroups.tf
  Synopsis: Security groups for the VPC
  Comments: N/A
*/


# Remove all rules from default security Group
resource "aws_default_security_group" "default_security_group" {
    vpc_id = "${ aws_vpc.vpc.id }"
    tags = {
        Name = "${ var.vpc_custom_name }-default-security-group"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}



##### Security Groups

# All-Egress
# Allows all outbound trafic for all VPC subnets
resource "aws_security_group" "security_group_egress" {
    vpc_id = "${ aws_vpc.vpc.id }"
    name = "${ var.vpc_custom_name }-public-egress"
    description = "Allows outbound traffic for management VPC subnet"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allows all outbound traffic for ${ var.vpc_custom_name } VPC subnets"
    }

    tags = {
        Name = "${ var.vpc_custom_name }-egress"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}


# Access-REDACTED-Networks
# Allows access from REDACTED Guest and REDACTED Corporate networks to the VPC via SSH and RDP
resource "aws_security_group" "security_group_access_REDACTED" {
    vpc_id = "${ aws_vpc.vpc.id }"
    name = "${ var.vpc_custom_name }-access-REDACTED"
    description = "Allows access from REDACTED Guest and REDACTED Corporate networks to management VPC"

    ingress {
        protocol  = "tcp"
        from_port = 22
        to_port   = 22
        cidr_blocks = ["REDACTED/32"]
        description = "REDACTED Guest Wifi ingress to SSH"
    }

    ingress {
        protocol  = "tcp"
        from_port = 3389
        to_port   = 3389
        cidr_blocks = ["REDACTED/32"]
        description = "REDACTED Guest Wifi ingress to RDP"
    }

    tags = {
        Name = "${ var.vpc_custom_name }-access-REDACTED"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}


# Public-Ingress
# Allows public inbound access to common web ports
resource "aws_security_group" "security_group_public_ingress" {
    vpc_id = "${ aws_vpc.vpc.id }"
    name = "${ var.vpc_custom_name }-public-ingress"
    description = "Allows public inbound access to common web ports"

    ingress {
        protocol  = "tcp"
        from_port = 80
        to_port   = 80
        cidr_blocks = ["0.0.0.0/0"]
        description = "Public internet"
    }

    ingress {
        protocol  = "tcp"
        from_port = 443
        to_port   = 443
        cidr_blocks = ["0.0.0.0/0"]
        description = "Public internet"
    }

    ingress {
        protocol  = "tcp"
        from_port = 8200
        to_port   = 8200
        cidr_blocks = ["0.0.0.0/0"]
        description = "Public Vault"
    }    

    tags = {
        Name = "${ var.vpc_custom_name }-public-ingress"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}


# Access-Intra-VPC
# Allows all communication within the VPC between instances
resource "aws_security_group" "security_group_vpc" {
    vpc_id = "${ aws_vpc.vpc.id }"
    name = "${ var.vpc_custom_name }-vpc"
    description = "Allows all communication within the management VPC subnet"

    ingress {
        protocol  = -1
        from_port = 0
        to_port   = 0
        cidr_blocks = ["${ local.vpc_cidr_block }"]
        description = "Allows traffic from ${ var.vpc_custom_name } ingress to all protocols and ports"
    }

    egress {
        protocol  = -1
        from_port = 0
        to_port   = 0
        cidr_blocks = ["${ local.vpc_cidr_block }"]
        description = "Allows traffic to ${ var.vpc_custom_name } egress to all protocols and ports"
    }
  
    tags = {
        Name = "${ var.vpc_custom_name }-vpc"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}

# Build
# Allows communication from management to build VPC subnet
resource "aws_security_group" "security_group_REDACTED" {
    vpc_id = "${ aws_vpc.vpc.id }"
    name = "${ var.vpc_custom_name }-build"
    description = "Allows communication from management to build VPC subnet"

    ingress {
        protocol  = -1
        from_port = 0
        to_port   = 0
        cidr_blocks = ["${ data.aws_vpc.default_build.cidr_block }"]
        description = "From build VPC subnet in to all protocols"
    }

    egress {
        protocol  = -1
        from_port = 0
        to_port   = 0
        cidr_blocks = ["${ data.aws_vpc.default_build.cidr_block }"]
        description = "From management VPC subnet out to all protocols"
    }

    tags = {
        Name = "${ var.vpc_custom_name }-build"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}

