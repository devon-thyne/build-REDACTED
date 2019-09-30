/*
  Filename: vars.tf
  Synopsis: Variables needed to deploy a single IAM role, attached policies, and optionally create instance profiles from with the created role
  Comments: N/A
*/


variable "build_user" {
    description = "Propagated build_user from parent module"
}

variable "iam_role_name" {
    description = "Input variable to module for the name of the created IAM role"
}

variable "iam_role_description" {
    description = "Input variable to module for the description of the created IAM role"
}

variable "assume_role_policy" {
    description = "Input variable to module for the role trust policy of the created IAM role" 
}

variable "iam_policy_list" {
    description = "Input variable to module for the list of policies to map to the created IAM role"
    type = list
}

variable "iam_instance_profile_name" {
    description = "Input variable to module for the name list of the IAM instance profiles to create and map the created IAM role to"
}
