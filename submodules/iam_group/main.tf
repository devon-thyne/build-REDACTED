/*
  Filename: main.tf
  Synopsis: Deploy a single IAM group with user memberships and policy attachments
  Comments: N/A
*/


# Create IAM Group
resource "aws_iam_group" "iam_group" {
    name = "${ var.iam_group_name }"
}


# Add IAM User memberships to IAM Group
resource "aws_iam_user_group_membership" "iam_user_group_membership" {
    groups = ["${ aws_iam_group.iam_group.name }"]
    count = length(var.iam_group_members_list)   
    user = var.iam_group_members_list[count.index]
}


# Map IAM Group to all Policies passed to module
resource "aws_iam_group_policy_attachment" "iam_group_policy_attach" {
    group = "${ aws_iam_group.iam_group.name }"
    count = length(var.iam_policy_list)
    policy_arn = var.iam_policy_list[count.index].arn
}

