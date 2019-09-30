/*
  Filename: iam-users.tf
  Synopsis: VPC IAM users
  Comments: N/A
*/


# service account for terraform
module "svc_terraform_iam_user" {
    source = "./submodules/iam_user"
    build_user = "${ var.build_user }"
    iam_user_name = "svc-terraform"
    iam_policy_list = [
        "${ data.aws_iam_policy.amazon_ec2_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_s3_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_vpc_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_iam_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_dynamodb_full_access_iam_policy }",
        "${ data.aws_iam_policy.amazon_directory_service_full_access_iam_policy }",
        "${ aws_iam_policy.workspace_full_access_iam_policy }"
    ]
}


# service account for cron
module "svc_cron_iam_user" {
    source = "./submodules/iam_user"
    build_user = "${ var.build_user }"
    iam_user_name = "svc-cron"
    iam_policy_list = [
        "${ data.aws_iam_policy.amazon_ec2_full_access_iam_policy }"
    ]
}


# service account for vault
module "svc_vault_iam_user" {
    source = "./submodules/iam_user"
    build_user = "${ var.build_user }"
    iam_user_name = "svc-vault"
    iam_policy_list = [
        "${ data.aws_iam_policy.amazon_ec2_read_only_access_iam_policy }",
        "${ aws_iam_policy.svc_vault_iam_policy }"
    ]
}

