/*
  Filename: variables.tf
  Synopsis: Terraform variables for VPC
  Comments: This file requires mandatory configuration before a new Terraform configuration can be applied. Please refer to README.md for important instructions on how to configure this file.
*/


##### Dynamic Terraform Variables

# To be changed to reflect the current user of this terraform module
variable "build_user" {
    description = "Defines the BuildUser for all resources and aids in pathing for backend configurations"
}

# Examples: 'test-bob', 'test-bob', 'REDACTED-management', or 'REDACTED-management'
variable "vpc_custom_name" {
    default = "management"
    description = "Defines the name of the VPC. Note, all other resources are going to be named and/or tagged off of this value"
}

# Please see 'Turn features on/off' section below for dynamically handling instances and key pairs



##### AWS Authentication Variables

# Please see README.md file for details on how to populate the terraform.tfvars file.
variable "access_key" {
	description = "AWS account access key read in from terrafrom.tfvars file by default"
}
variable "secret_key" {
	description = "AWS account secret key read in from terrafrom.tfvars file by default"
}



##### AWS Variables

variable "aws_region" {
    default = "REDACTED"
    description = "AWS Region"
}



##### VPC Variables

variable "vpc_custom_octet" {
    default = "10.200"
    description = "Defines the internal ip range for the VPC"
}

variable "vpc_REDACTED_default_name" {
    default = "REDACTED"
    description = "AWS vpc name of default REDACTED vpc"
}

variable "REDACTED_development_public_key" {
    default = "ssh-rsa REDACTED"
    description = "Public key contents for the REDACTED AWS key pair"
}

variable "REDACTED_vault_public_key" {
    default = "ssh-rsa REDACTED"
    description = "Public key contents for the REDACTED AWS key pair"
}

variable "REDACTED_management_public_key" {
    default = "ssh-rsa REDACTED"
    description = "Public key contents for the REDACTED AWS key pair"
}



##### Turn features on or off

variable "aws_instances" {
    type = bool
    default = true
    description = "Conditional flag to tell terraform to spin up instances or not. Default is to not spin them up (false)"
}

variable "aws_keypair" {
    type = bool
    default = true
    description = "Conditional flag to tell terraform to generate key pairs or not. Default is to not generate them (false)"
}

# Note, the conditional flag above 'aws_keypair' must be set to 'false' in order to use this existing key pair name
variable "existing_aws_keypair_name" {
    default = "EXISTING KEYPAIR NAME"
    description = "Stores the value of an existing AWS key pair's name if the user wishes to spin up instances with an existing key pair instead of generating a new one."
}



##### Directory Service Variables

# This is the Netbios name of the domain
variable "ds_netbios" { default = "REDACTED" }

# This is the FQDN of the domain
variable "ds_fqdn" { default = "REDACTED" }

# Temporary password assigned to the Directory Service 'Admin'
variable "ds_admin_password" { default = "!bobbybobbersonisawesome!" }



##### Instance Variables
variable "git_name" {
  description = "Git Username to download repositories.  Used by the userdata bootstrap process"
}

variable "git_token" {
  description = "Git Username to download repositories.  Used by the userdata bootstrap process"
}
