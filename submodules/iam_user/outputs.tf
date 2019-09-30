/*
  Filename: outputs.tf
  Synopsis: Output variables from deployment of a a single IAM user and attached policies
  Comments: N/A
*/


# IAM User name
output "name" {
    value = "${ aws_iam_user.iam_user.name }"
}

