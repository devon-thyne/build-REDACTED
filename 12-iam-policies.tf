/*
  Filename: iam-policies.tf
  Synopsis: VPC IAM policies
  Comments: N/A
*/


##### Create New Policies

# Business workspace full access policy
resource "aws_iam_policy" "workspace_full_access_iam_policy" {
    name = "build-workspace-fullaccess-policy"
    policy = file("./templates/iam-policy-definitions/workspace-fullaccess-policy.json")
}

# Vault Service Account policy
resource "aws_iam_policy" "svc_vault_iam_policy" {
    name = "build-svc-vault-iam-policy"
    policy = file("./templates/iam-policy-definitions/svc-vault-iam-policy.json")
}

# VM import policy
resource "aws_iam_policy" "vmimport_iam_policy" {
    name = "build-vmimport-policy"
    policy = file("./templates/iam-policy-definitions/vmimport-policy.json")
}

# Default EC2 EBS policy
resource "aws_iam_policy" "default_ec2_ebs_iam_policy" {
    name = "build-default-ec2-ebs-policy"
    policy = file("./templates/iam-policy-definitions/default-ec2-ebs-policy.json")
}

# Vault S3 policy
resource "aws_iam_policy" "vault_s3_iam_policy" {
    name = "build-REDACTED-s3-policy"
    policy = file("./templates/iam-policy-definitions/vault-s3-policy.json")
}

# Patch S3 policy
resource "aws_iam_policy" "patch_s3_iam_policy" {
    name = "build-patch-s3-policy"
    policy = file("./templates/iam-policy-definitions/cron-s3-policy.json")
}

# Vault KMS Unseal policy
resource "aws_iam_policy" "vault_kms_unseal_iam_policy" {
    name = "build-REDACTED-kms-unseal-policy"
    policy = file("./templates/iam-policy-definitions/vault-kms-unseal-policy.json")
}

# User MFA policy
resource "aws_iam_policy" "user_mfa_iam_policy" {
    name = "build-user-mfa-policy"
    policy = file("./templates/iam-policy-definitions/user-mfa-policy.json")
}


##### Capture Existing Default IAM policies that come with AWS

data "aws_iam_policy" "amazon_ec2_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonEC2FullAccess"
}

data "aws_iam_policy" "amazon_ec2_read_only_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

data "aws_iam_policy" "amazon_ec2_role_for_ssm_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

data "aws_iam_policy" "amazon_ec2_container_registry_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

data "aws_iam_policy" "amazon_s3_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "amazon_s3_read_only_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

data "aws_iam_policy" "amazon_ssm_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMFullAccess"
}

data "aws_iam_policy" "amazon_vpc_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonVPCFullAccess"
}

data "aws_iam_policy" "amazon_iam_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/IAMFullAccess"
}

data "aws_iam_policy" "amazon_dynamodb_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonDynamoDBFullAccess"
}

data "aws_iam_policy" "amazon_directory_service_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AWSDirectoryServiceFullAccess"
}

data "aws_iam_policy" "amazon_lambda_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AWSLambdaFullAccess"
}

data "aws_iam_policy" "amazon_elb_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/ElasticLoadBalancingFullAccess"
}

data "aws_iam_policy" "amazon_rds_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonRDSFullAccess"
}

data "aws_iam_policy" "amazon_inspector_full_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/AmazonInspectorFullAccess"
}

data "aws_iam_policy" "view_only_access_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/job-function/ViewOnlyAccess"
}

data "aws_iam_policy" "support_user_iam_policy" {
    arn = "arn:aws-us-gov:iam::aws:policy/job-function/SupportUser"
}

