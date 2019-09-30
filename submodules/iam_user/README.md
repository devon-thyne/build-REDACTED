IAM User Module
===============

This space includes a templated Terraform module to create a single AWS IAM User and associate it to other necessary IAM resources.

Dependencies
------------
	
* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, S3, and DynamoDB

IAM User Module Details
-----------------------

The following are the details concerning the IAM User module:

### Input Variables

| Name            | Status    | Description                                                                                                                          |
| --------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| build_user      | mandatory | Propagated BuildUser tag from parent module                                                                                          |
| iam_user_name   | mandatory | Input variable to module for the name of the created IAM user                                                                        |
| iam_policy_list | optional  | Input variable to module for the list of policies resources (`aws_iam_policy`) from the parent module to map the created IAM user to |

### Output Variables

| Name      | Description                        |
| --------- | ---------------------------------- |
| name      | The created IAM User object's name |

IAM User Module Instructions
============================

1. Copy the IAM User Module to the following directory within your parent Terraform configuration:
```
/PARENT TERRAFORM CONFIGURATION/submodules/iam_user
```

2. For usage within the parent Terraform configuration, an IAM User resource can be created as follows:
```
    module "EXAMPLE_RESOURCE_NAME" {
        source = "./modules/iam_user"
        build_user = "${ var.build_user }"
        iam_user_name = "IAM USER NAME"
        iam_policy_list = [
            "${ aws_iam_policy.EXAMPLE_POLICY_1 }",
            "${ aws_iam_policy.EXAMPLE_POLICY_2 }"
        ]
    }
```

3. To reference the created IAM User elsewhere in your parent Terraform configuration, you can access the output `name` attribute.  Please note that this step reference the example `EXAMPLE_RESOURCE_NAME` resource defined in number 2 above.
```
module.EXAMPLE_RESOURCE_NAME.name
```
