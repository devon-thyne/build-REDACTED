/*
  Filename: iam-roles.tf
  Synopsis: VPC IAM roles
  Comments: N/A
*/


##### Default role

# Dependency for all iam role creation
# Provides access to ec2 metadata and the ability to read s3 buckets
module "default_iam_role" {
    source = "./submodules/iam_role"
    build_user = "${ var.build_user }"
    iam_role_name = "build-default"
    iam_role_description = "Provides access to ec2 metadata and the ability to read s3 buckets"
    assume_role_policy = file("./templates/iam-role-definitions/ec2-role-trust-policy.json")
    iam_policy_list = [
        "${ data.aws_iam_policy.amazon_ec2_read_only_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_s3_read_only_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_ec2_role_for_ssm_iam_policy }",
        "${ aws_iam_policy.default_ec2_ebs_iam_policy }"
    ]
    iam_instance_profile_name = "build-default"
}



##### Vault role

# Provides access to ec2 metadata, ability to read s3 buckets, and write to backup vault s3 bucket
module "vault_iam_role" {
    source = "./submodules/iam_role"
    build_user = "${ var.build_user }"
    iam_role_name = "build-REDACTED"
    iam_role_description = "Provides access to ec2 metadata the ability to read s3 buckets and write to backup vault s3 bucket"
    assume_role_policy = file("./templates/iam-role-definitions/ec2-role-trust-policy.json")
    iam_policy_list = [
        "${ data.aws_iam_policy.amazon_ec2_read_only_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_s3_read_only_access_iam_policy }",
        "${ aws_iam_policy.svc_vault_iam_policy }",
        "${ aws_iam_policy.default_ec2_ebs_iam_policy }",
        "${ aws_iam_policy.vault_kms_unseal_iam_policy }"
    ]
    iam_instance_profile_name = "build-REDACTED"
}


##### Orchestration Terraform role

# purpose: use vault to assume terraform role to perform work
# Provides access to AWS Resources to support automation managed by Terraform
module "orchestration_terraform_iam_role" {
    source = "./submodules/iam_role"
    build_user = "${ var.build_user }"
    iam_role_name = "build-orchestration-terraform"
    iam_role_description = "Provides access to AWS Resources to support automation managed by Terraform"
    assume_role_policy = file("./templates/iam-role-definitions/ec2-role-trust-policy.json")
    iam_policy_list = [
        "${ data.aws_iam_policy.amazon_dynamodb_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_ec2_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_ec2_container_registry_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_s3_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_ssm_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_directory_service_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_lambda_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_elb_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_rds_full_access_iam_policy }",
        "${ aws_iam_policy.workspace_full_access_iam_policy }"
    ]
    iam_instance_profile_name = ""
}



##### Identity default role

# Provides federated users access to ViewOnlyAccess permissions
module "identity_default_iam_role" {
    source = "./submodules/iam_role"
    build_user = "${ var.build_user }"
    iam_role_name = "build-identity-default"
    iam_role_description = "Provides federated users access to ViewOnlyAccess permissions"
    assume_role_policy = file("./templates/iam-role-definitions/user-role-trust-policy.json")
    iam_policy_list = [
        "${ data.aws_iam_policy.view_only_access_iam_policy }",
        "${ data.aws_iam_policy.support_user_iam_policy }"
    ]
    iam_instance_profile_name = ""
}

