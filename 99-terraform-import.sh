#!/bin/bash

: '
  File: terraform-import.txt
  Synopsis: Executed commands to perform importation of pre-existing build-REDACTED infrastructure
    into this Terraform configuration.
'


##### VPC

# management
terraform import aws_vpc.vpc REDACTED

##### Subnets

# management-az1a-subnet
terraform import aws_subnet.subnet_private_1a REDACTED

# management-az1b-subnet
terraform import aws_subnet.subnet_private_1b REDACTED

# management-az1c-subnet
terraform import aws_subnet.subnet_private_1c REDACTED

##### Gateways

# management-default
terraform import aws_internet_gateway.internet_gateway REDACTED

##### Routes

# build to management vpc peering route
terraform import aws_route.default_route_build_peer REDACTED_111.111.111.111/16

##### Security Groups

# management-default
terraform import aws_default_security_group.default_security_group REDACTED

# management-public-egress
terraform import aws_security_group.security_group_egress REDACTED

# management-access-REDACTED
terraform import aws_security_group.security_group_access_REDACTED REDACTED

# management-vpc
terraform import aws_security_group.security_group_vpc REDACTED

# management-build
terraform import aws_security_group.security_group_build REDACTED

##### Instances

# non-persistent build vault
terraform import aws_instance.instance_vault[0] REDACTED

##### Elastic IP Addresses

# vault
terraform import module.instance_vault.aws_eip.instance[0] REDACTED
terraform import module.instance_vault.aws_eip_association.instance[0] REDACTED

##### Key Pairs

# build-REDACTED
terraform import aws_key_pair.build_REDACTED_key_pair[0] build-REDACTED

##### VPC Peering

# build/vpc-REDACTED - management/vpc-REDACTED
terraform import aws_vpc_peering_connection.default_build_peer REDACTED

##### Directory Service

# directory.REDACTED.internal
terraform import aws_directory_service_directory.directory_service REDACTED

##### S3 Buckets

terraform import aws_s3_bucket.build_REDACTED_s3 build-REDACTED

terraform import aws_s3_bucket.build_terraform_REDACTED_s3 build-terraform-REDACTED

##### KMS Keys

# vault
terraform import aws_kms_key.vault REDACTED

# vault alias
terraform import aws_kms_alias.vault alias/vault-kms-unseal-key


##### IAM Policies

# build-workspace-fullaccess-policy
terraform import aws_iam_policy.workspace_full_access_iam_policy arn:aws-us-gov:iam::REDACTED:policy/build-workspace-fullaccess-policy

# build-svc-vault-iam-policy
terraform import aws_iam_policy.svc_vault_iam_policy arn:aws-us-gov:iam::REDACTED:policy/build-svc-vault-iam-policy

# build-vmimport-policy
terraform import aws_iam_policy.vmimport_iam_policy arn:aws-us-gov:iam::REDACTED:policy/build-vmimport-policy

# build-default-ec2-ebs-policy
terraform import aws_iam_policy.default_ec2_ebs_iam_policy arn:aws-us-gov:iam::REDACTED:policy/build-default-ec2-ebs-policy

# build-REDACTED-s3-policy
terraform import aws_iam_policy.vault_s3_iam_policy arn:aws-us-gov:iam::REDACTED:policy/build-REDACTED-s3-policy

# build-cron-s3-policy
terraform import aws_iam_policy.patch_s3_iam_policy arn:aws-us-gov:iam::REDACTED:policy/build-cron-s3-policy

# build-REDACTED-kms-unseal-policy
terraform import aws_iam_policy.vault_kms_unseal_iam_policy arn:aws-us-gov:iam::REDACTED:policy/build-REDACTED-kms-unseal-policy


##### IAM Users

# svc-REDACTED
terraform import module.svc_REDACTED_iam_user.aws_iam_user.iam_user svc-REDACTED


##### IAM Groups

# ServiceAccounts
terraform import module.service_accounts_iam_group.aws_iam_group.iam_group ServiceAccounts

##### IAM User Group Memberships

# Service Accounts Group
terraform import module.service_accounts_iam_group.aws_iam_user_group_membership.iam_user_group_membership[0] svc-REDACTED/ServiceAccount

##### IAM Roles

# build-default
terraform import module.default_iam_role.aws_iam_role.iam_role build-default

##### IAM Instance Profiles

# build-default
terraform import module.default_iam_role.aws_iam_instance_profile.iam_instance_profile[0] build-default

##### IAM Role Policy Attachments

# build-default
terraform import module.default_iam_role.aws_iam_role_policy_attachment.iam_role_policy_attach[0] build-default/arn:aws-us-gov:iam::aws:policy/AmazonEC2ReadOnlyAccess

terraform import module.default_iam_role.aws_iam_role_policy_attachment.iam_role_policy_attach[1] build-default/arn:aws-us-gov:iam::aws:policy/AmazonS3ReadOnlyAccess

terraform import module.default_iam_role.aws_iam_role_policy_attachment.iam_role_policy_attach[2] build-default/arn:aws-us-gov:iam::aws:policy/AmazonEC2RoleforSSM

terraform import module.default_iam_role.aws_iam_role_policy_attachment.iam_role_policy_attach[3] build-default/arn:aws-us-gov:iam::REDACTED:policy/build-default-ec2-ebs-policy


##### IAM User Policy Attachments

# svc-REDACTED
terraform import module.svc_cron_iam_user.aws_iam_user_policy_attachment.iam_user_policy_attach[0] svc-REDACTED/arn:aws-us-gov:iam::aws:policy/AmazonEC2FullAccess
