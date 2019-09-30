IAM Group Module
================

This space includes a templated Terraform module to create a single AWS IAM Group and associate it to other necessary IAM resources.

Dependencies
------------
	
* Terraform 0.12
* AWS Administrator level privileges or privileges to manage IAM

IAM Group Module Details
------------------------

The following are the details concerning the IAM Group module:

### Input Variables

| Name                   | Status    | Description                                                                       |
| ---------------------- | --------- | --------------------------------------------------------------------------------- |
| build_user             | mandatory | Propagated BuildUser tag from parent module                                       |
| iam_group_name         | mandatory | Input variable to module for the name of the created IAM group                    |
| iam_group_members_list | mandatory | Input variable to module for the list of members to add to the created IAM group  |
| iam_policy_list        | optional  | Input variable to module for the list of policies to map the created IAM group to |

IAM Role Module Instructions
============================

1. Copy the IAM Group Module to the following directory within your parent Terraform configuration:
```
/PARENT TERRAFORM CONFIGURATION/submodules/iam_group
```

2. For usage within the parent Terraform configuration, an IAM Group resource can be created as follows:
```
    module "EXAMPLE_RESOURCE_NAME" {
        source = "./modules/iam_group"
        build_user = "${ var.build_user }"
        iam_group_name = "EXAMPLE-GROUP-NAME"
        iam_group_members_list = [
            "${ module.EXAMPLE_IAM_USER_1.name }",
            "${ module.EXAMPLE_IAM_USER_2.name }" 
        ]
        iam_policy_list = [
            "${ aws_iam_policy.EXAMPLE_POLICY_1 }",
            "${ aws_iam_policy.EXAMPLE_POLICY_2 }"
        ]
    }
```
