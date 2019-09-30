Build-REDACTED Module
======================

This space includes Terraform code to setup and configure Build-REDACTED including all necessary IAM resources.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, S3, and DynamoDB
* AWS S3 bucket named `build-terraform-REDACTED` to store the terraform statefile. To help, below is example syntax for AWS CLI commands to create an S3 bucket programmatically:
    ```
    aws s3api create-bucket --bucket build-terraform-REDACTED --region REDACTED --create-bucket-configuration LocationConstraint=REDACTED
    aws s3api put-public-access-block --bucket build-terraform-REDACTED --public-access-block BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
    ```

* AWS DynamoDB table named `build-terraform-REDACTED` to store the locking information for the terraform statefile stored in `build-terraform-REDACTED`. To help, below is example syntax for AWS CLI commands to create a DynamoDB table programmatically:
    ```
    aws dynamodb create-table --table-name build-terraform-REDACTED --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH
    ```

* IAM Policies per Role limit increase request from 10 to 20 for any AWS account running this configuration. The default limit is set to 10 IAM policies per role, but this is a soft limit. A request for increase can be made through the AWS service portal [here] (https://console.amazonaws-us-gov.com/support/cases#/create)
 * Choose: Service limit increase
 * Limit type: IAM Groups and Users
 * Limit: Policies per Role
 * New limit value: 20

Subdirectory Structure
----------------------

* templates/ - A subdirectory to house all customer managed JSON policy definition templates
 * templates/iam-policy-definitions/ - A subdirectory to house customer managed JSON policy definitions
 * templates/iam-role-defninitions/ - A subdirectory to house customer managed JSON role trust policy definitions
* submodules/ - A subdirectory to house all templated Terraform submodules used in this configuration

Setup of Build REDACTED VPC
=============================

When running on a new aws account the following steps should be taken:

1. Clone REDACTED-terraform repository
2. Create `terraform.tfvars` file to store AWS credentials or for ease just copy the template file `terraform.tfvars.template` that has been provided and populate its contents accordingly.
```
vi REDACTED-terraform/environments/build-REDACTED/terraform.tfvars
```
or
```
mv REDACTED-terraform/environments/build-REDACTED/terraform.tfvars.template REDACTED-terraform/modules/build-REDACTED/terraform.tfvars
```

3. Populate terraform.tfvars file with AWS access key and secret key.
```
access_key = "YOUR AWS ACCOUNT ACCESS KEY"
secret_key = "YOUR AWS ACCOUNT SECRET KEY"
```

4. Create backend.tfvars file to store S3 backend configurations or for ease just copy the template file `backend.tfvars.template` that has been provided and populate its contents accordingly.
```
vi REDACTED-terraform/environments/build-REDACTED/backend.tfvars
```
or
```
mv REDACTED-terraform/environments/build-REDACTED/backend.tfvars.template REDACTED-terraform/modules/build-REDACTED/backend.tfvars
```

5. Populate backend.tfvars file described in 5. with redundant AWS credentials as well as configuration information for storing the terraform state file. Note, to avoid stomping on others' state files, it is a good idea to have the directory where the `key` is being stored contain your userID in the name to assure that it is a unique location.
```
EXAMPLE FILE CONTENTS:
##### Terraform s3 backend configuration
region = "REDACTED"
bucket = "build-terraform-REDACTED"
dynamodb_table = "build-terraform-REDACTED"
key = "bob/build-REDACTED.tfstate"
```

6. Open build project variables file
```
vi REDACTED-terraform/environments/build-REDACTED/00-variables.tf
```

7. Adjust value for `build_user` to reflect the current user configuring the terraform module
```
EXAMPLE:
    variable "build_user" {
        default = "bob"
        description = "Defines the BuildUser for all resources"
    }
```

8. Adjust value for `vpc_custom_name` only if you wish to configure a new VPC other than `management` to reflect the name of the VPC.
```
Examples: 'test-bob', 'test-bob', 'build-REDACTED', or 'REDACTED-management'
    variable "vpc_custom_name" {
        default = "management"
        description = "Defines the name of the VPC. Note, all other resources are going to be named and/or tagged off of this value"
    }
```

9. Adjust values for `aws_region` and `vpc_custom_octet` to match desired aws region and ip address space
```
EXAMPLES:
    variable "aws_region" {
        default = "REDACTED"
        description = "AWS Region"
    }
    variable "vpc_custom_octet" {
        default = "10.222"
        description = "Defines the internal ip range for the VPC"
    }
```

10. Set `default` values for conditional flags `aws_instances`, `aws_keypair` and/or `existing_aws_keypair_name`.
    * If you wish to have terraform spin up new instances, manually set `aws_instances` to `true`, otherwise terraform will ignore any instances defined in `06-instances.tf`.
    * For details about SSH key generation/management, please see the `Generate New SSH` or `Use Existing SSH Key` sections below.

11. Commence to creating your VPC additional resources if necessary in all file. Main focuses are:
    * Additional/changes to IP traffic routing in the routes.tf file if needed
    * Additional/changes to security groups in security-groups.tf file if needed
    * Defining of AWS instances in instance.tf file if needed when the flag `aws_instances` in `00-variables.tf` file is set to true
    * Defining of AWS key pairs in key-pairs.tf file if needed when the flag `aws_keypair` in `00-variables.tf` file is set to true

12. Once satisfied with changes, save locally and commit changes to git. **Create merge request and receive approval before proceeding**
13. Navigate to the newly created and approved build project module directory before proceeding
```
cd REDACTED-terraform/environments/build-REDACTED
```

14. Initialize Terraform with specific backend pointing to backend.tfvars file. **Do not** execute without the `--backend.tfvars` file or you will be prompted for all the information via the command line intended to be contained within the file.
```
terraform init -backend-config=backend.tfvars
```

15. Review Terraform plan
```
terraform plan
```

16. Apply Terraform changes and confirm with `yes`
```
terraform apply
```

Generate New SSH Key
--------------------

1. If the user decides they want to generate a new keypair, the `aws_keypair` conditional flag `default` must be set to `true`. This will make it so each new instance will be spun up with the key pair defined in the `07-keypairs.tf` file instead of using the variable to store an existing key pair name `existing_aws_keypair_name`. When generating a new key pair, the steps are as follows:
2. Manually generate a new key pair. You may decide to name it however you choose and decide whether or not to give it a passphrase.
```
ssh-keygen -t rsa
```

3. Whatever the name specified for the new keypair in whatever directory it was chosen to be stored in, please file the file with the chosen `FILENAME.pub`. Copy and paste the contents of this file into the terraform attribute `public_key`.
```
    resource "aws_key_pair" "key_pair" {
        count = "${ var.aws_keypair ? 1 : 0 }"
        key_name = "${ var.vpc_custom_name }-ec2-keypair"
        public_key = "PASTE FILE CONTENTS HERE"
    }
```

Use Existing SSH Key
--------------------

If the user decides that they want to use an existing AWS keypair, the `aws_keypair` conditional flag `default` it to be left as `false`. This will ensure that any new key pair resource defined in the 07-keypairs.tf file will be ignored, and all new instances will be spun up using the exiting key pair as defined in variable `existing_aws_keypair_name`.

```
    variable "existing_aws_keypair_name" {
        default = ""
        description = "Stores the value of an existing AWS key pair's name if the user wishes to spin up instances with an existing key pair instead of generating a new one."
    }
```

build-REDACTED Module Details
===============================

The following are the details concerning the build-REDACTED VPC

### Subnets

| Terraform name    | AWS Tag Name           | CIDR         | Description                    |
| ----------------- | ---------------------- | ------------ | -------------------------------|
| subnet_private_1a | (VPC NAME)-az1a-subnet | x.x.1.0/24   | Subnet for availability zone A |
| subnet_private_1b | (VPC NAME)-az1b-subnet | x.x.2.0/24   | Subnet for availability zone B |
| subnet_private_1c | (VPC NAME)-az1c-subnet | x.x.3.0/24   | Subnet for availability zone C |

### Security Groups

| Terraform Name                | AWS Tag Name              | Description                                                               |
| ----------------------------- | ------------------------- | ------------------------------------------------------------------------- |
| default_security_group        | (VPC NAME)-default        | Default VPC security group                                                |
| security_group_egress         | (VPC NAME)c--egress       | Allows outbound traffic for management VPC subnet                         |
| security_group_access_REDACTED     | (VPC NAME)-access-REDACTED     | Allows access from REDACTED Guest and REDACTED Corporate networks to management VPC |
| security_group_vpc            | (VPC NAME)-vpc            | Allows all communication within the management VPC subnet                 |
| security_group_public_ingress | (VPC NAME)-public-ingress | Allows public inbound access to common web ports                          |

### Instances

| Terraform name           | AWS Tag Name | Key Pair         | EIP    | Description                                                                          |
| ------------------------ | ------------ | ---------------- | ------ | ------------------------------------------------------------------------------------ |
| instance_cron            | cron/        | build-REDACTED |        | Cronbox dedicated automation and aws environment cleanup                             |
| instance_vault           | vault/       | build-REDACTED | vault/ | System dedicated to secrets management, certificate management, and access brokerage |

### Key Pairs

| Terraform Name             | AWS Tag Name      | Description                        |
| -------------------------- | ----------------- | ---------------------------------- |
| build_REDACTED_key_pair | build-REDACTED | Build REDACTED VPC SSH key pair |
| build_REDACTED_key_pair       | build-REDACTED       | Build REDACTED SSH key pair           |
| build_REDACTED_key_pair  | build-REDACTED  | Build REDACTED SSH key pair      |

### S3 Buckets

| Terraform Name                 | AWS Tag Name                | Description                 |
| ------------------------------ | --------------------------- | --------------------------- |
| backups_vault_s3               | build-backups-REDACTED         | Vault bucket                |
| build_terraform_REDACTED_s3 | build-terraform-development | Deveopment Terraform bucket |

### KMS Keys

| Terraform Name | AWS Alias            | Description               |
| -------------- | -------------------- | ------------------------- |
| vault          | vault-kms-unseal-key | Vault auto-unseal KMS key |

### IAM Policies

| Terraform Module Name            | AWS Tag Name                      | Description                                           |
| -------------------------------- | --------------------------------- | ----------------------------------------------------- |
| default_ec2_ebs_iam_policy       | build-default-ec2-ebs-policy      | TBD                                                   |
| svc_vault_iam_policy             | build-svc-vault-iam-policy        | TBD                                                   |
| vault_s3_iam_policy              | build-REDACTED-s3-policy             | TBD                                                   |
| vmimport_iam_policy              | build-vmimport-policy             | TBD                                                   |
| workspace_full_access_iam_policy | build-workspace-fullaccess-policy | TBD                                                   |
| patch_s3_iam_policy              | build-patch-s3-policy             | TBD                                                   |
| vault_kms_unseal_iam_policy      | build-REDACTED-kms-unseal-policy     | Enable auto-unsealing Vault instance with AWS KMS key |
| user_mfa_policy                  | build-user-mfa-policy             | Force console users to have MFA configured on their account to have access to perform any AWS commands |

### IAM Users

| Terraform Module Name  | AWS Tag Name  | Description                                                                                        |
| ---------------------- | ------------- | -------------------------------------------------------------------------------------------------- |
| svc_terraform_iam_user | svc-terraform | Enable Terraform scripts to spin up aws resources                                                  |
| svc_cron_iam_user      | svc-cron      | Enable linux cron box to obtain ec2 metadata and destroy irrelevant resources such as test systems |
| svc_vault_iam_user     | svc-vault     | Enable Vault to assume other roles for future automation needs                                     |

### IAM Groups

| Terraform Module Name      | AWS Tag Name    | Description                                                  |
| -------------------------- | --------------- | ------------------------------------------------------------ |
| service_accounts_iam_group | ServiceAccounts | IAM group for service accounts to ensure easier organization |

### IAM Roles

| Terraform Module Name            | AWS Tag Name                  | Description                                                                                        |
| -------------------------------- | ----------------------------- | -------------------------------------------------------------------------------------------------- |
| default_iam_role                 | build-default                 | Provides access to ec2 metadata and the ability to read s3 buckets                                 |
| vault_iam_role                   | build-REDACTED                   | Provides access to ec2 metadata the ability to read s3 buckets and write to backup vault s3 bucket |
| patch_iam_role                   | build-patch                   | TBD                                                                                                |
| vmimport_iam_role                | build-vmimport                | Provides the ability to import virtual machines into ec2                                           |
| orchestration_terraform_iam_role | build-orchestration-terraform | Provides access to AWS Resources to support automation managed by Terraform                        |
| orchestration_concourse_iam_role | build-orchestration-concourse | Provides access to AWS Resources to support automation managed by Concourse                        |
| orchestration_awx_iam_role       | build-orchestration-awx       | Provides access to AWS Resources to support automation managed by AWX                              |
| identity_default_iam_role        | build-identity-default        | Provides federated users access to ViewOnlyAccess permissions                                      |
| identity_development_iam_role    | build-identity-development    | Provides federated users access to  permissions                                                    |

### IAM Instance Profiles

| Terraform Module Name            | AWS Tag Name                  | Description   |
| -------------------------------- | ----------------------------- | ------------- |
| default_iam_role                 | build-default                 | TBD           |
| vault_iam_role                   | build-REDACTED                   | TBD           |


Destroying the VPC
==================

To destroy the entire VPC the following command is used:
```
terraform destroy
```

In some scenarios, it might be useful to know how to fully cleanup or start fresh with an existing Terraform configuration. If you have already run `terraform init` at any point, it can be tricky making certain changes. If you wish to keep your existing configuration files by initialize the project completely fresh, use the following steps:

1. Remove the generated `.terraform/` directory
```
rm -R .terraform
```

2. If you did not configure a remote backend for Terraform statefile previously, you might have a `terraform.tfstate` and `terraform.tfstate.backup` file. These also should be removed to fully cleanup.
```
rm terraform.tfstate
rm terraform.tfstate.backup
```

Author Information
------------------

* Devon Thyne (devon-thyne)
