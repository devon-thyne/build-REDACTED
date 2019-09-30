/*
  Filename: main.tf
  Synopsis: Deploy a single IAM user with policy attachments
  Comments: N/A
*/


# Create IAM User
resource "aws_iam_user" "iam_user" {
    name = "${ var.iam_user_name }"
    tags = {
        Name = "${ var.iam_user_name }"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}


# Map IAM User to all IAM Policies passed to module
resource "aws_iam_user_policy_attachment" "iam_user_policy_attach" {
    user = "${ aws_iam_user.iam_user.name }"
    count = length(var.iam_policy_list)
    policy_arn = var.iam_policy_list[count.index].arn
}

