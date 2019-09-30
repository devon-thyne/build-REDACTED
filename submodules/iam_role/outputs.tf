/*
  Filename: outputs.tf
  Synopsis: Output variables from deployment of a a single IAM role and attached policies
  Comments: N/A
*/


# IAM Instance Profile ID
output "instance_profile_id" {
    value = "${ aws_iam_instance_profile.iam_instance_profile[0].id }"
}

