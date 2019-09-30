IAM Role Module
===============

This space includes a templated Terraform module to create a single AWS IAM Role and associate it to other necessary IAM resources.

Dependencies
------------
	
* Terraform 0.12
* AWS Administrator level privileges or privileges to manage IAM

IAM Role Module Details
-----------------------

The following are the details concerning the IAM Role module:

### Input Variables

| Name                           | Status    | Description                                                                                                                          |
| ------------------------------ | --------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| build_user                     | mandatory | Propagated BuildUser tag from parent module                                                                                          |
| iam_role_name                  | mandatory | Input variable to module for the name of the created IAM role                                                                        |
| iam_role_description           | optional  | Input variable to module for the description of the created IAM role                                                                 |
| assume_role_policy             | mandatory | Input variable to module for the role trust policy of the created IAM role                                                           |
| iam_policy_list                | optional  | Input variable to module for the list of policies resources (`aws_iam_policy`) from the parent module to map the created IAM role to |
| iam_instance_profile_name      | optional  | Input variable to module for the name of the IAM instance profiles to create and map the created IAM role to                         |

IAM Role Module Instructions
============================

1. Copy the IAM Role Module to the following directory within your parent Terraform configuration:
```
/PARENT TERRAFORM CONFIGURATION/submodules/iam_role
```

2. For usage within the parent Terraform configuration, an IAM Role resource can be created as follows:
```
    module "EXAMPLE_RESOURCE_NAME" {
        source = "./modules/iam_role"
        build_user = "${ var.build_user }"
        iam_role_name = "${ var.vpc_custom_name }-ROLE-NAME"
        iam_role_description = "EXAMPLE ROLE DESCRIPTION"
        assume_role_policy = file("./iam-role-definitions/EXAMPLE_ROLE_TRUST_POLICY_FILE.json")
        iam_policy_list = [
            "${ aws_iam_policy.EXAMPLE_POLCIY_1 }",
            "${ aws_iam_policy.EXAMPLE_POLCIY_2 }"
        ]
        iam_instance_profile_name_list = [
            "EXAMPLE-INSTANCE-PROFILE-NAME"
        ]
    }
```
