/*
  Filename: iam-groups.tf
  Synopsis: VPC IAM groups
  Comments: N/A
*/


# Service Accounts IAM Group
module "service_accounts_iam_group" {
    source = "./submodules/iam_group"
    build_user = "${ var.build_user }"
    iam_group_name = "ServiceAccounts"
    iam_group_members_list = [
        "${ module.svc_terraform_iam_user.name }",
        "${ module.svc_cron_iam_user.name }",
        "${ module.svc_vault_iam_user.name }"
    ]
    iam_policy_list = []
}

