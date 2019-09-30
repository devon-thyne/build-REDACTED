/*
  Filename: vars.tf
  Synopsis: Variables needed to deploy a single IAM group with user memberships and attached policies
  Comments: N/A
*/


variable "build_user" {
    description = "Propagated build_user from parent module"
}

variable "iam_group_name" {
    description = "Input variable to module for the name of the created IAM group"
}

variable "iam_group_members_list" {
    description = "Input variable to module for the list of members to add to the created IAM group"
    type = list
}

variable "iam_policy_list" {
    description = "Input variable to module for the list of policies to map the created IAM user to"
    type = list
}

