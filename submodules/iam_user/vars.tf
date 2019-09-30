/*
  Filename: vars.tf
  Synopsis: Variables needed to deploy a single IAM user and attached policies
  Comments: N/A
*/


variable "build_user" {
    description = "Propagated build_user from parent module"
}

variable "iam_user_name" {
    description = "Input variable to module for the name of the created IAM user"
}

variable "iam_policy_list" {
    description = "Input variable to module for the list of policies to map the created IAM user to"
    type = list
}

