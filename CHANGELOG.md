# Latest Version
0.12-000007

# Version History

## Version 0.12-000007 (devon-thyne)
### Enhancement - import existing elastic ip address (EIP) for vault
* Re-route existing eip for the old non-persistent Vault to the new persistent one
* Destroy old non-persistent Vault
* Reconfigure security group access-REDACTED to use new static ip

### Enhancement - import existing build-managemet key pair
* Import existing Build-REDACTED public key into module

### Enhangement - created new public ingress security group
* Create new security group that exposes commonly used web ports to the internet

## Version 0.12-000006 (devon-thyne)
### Enhancement - Addition of AWX, Nessus, and Cron instances
* Adding instances for Tenable Nessus, AWX, Vault and cron using aws-instance module
* Imported non-persistent build vault due to merge conflict
* Modified `management-access-REDACTED` security group to permit TCP 8200 from REDACTED guest wireless
* Outputs.conf was updated to include all instances created from module

### Bug Fix - Termination Protection and Public IP
* Existing instances recieved aws termination protection and public ip addresses

## Version 0.12-000005 (devon-thyne)
### Enhancement - Addition of build-user-mfa-policy in build-REDACTED
* Edited trust policy on all roles with the ec2 default to also include the svc-vault user
* Created policy to allow svc-vault to assume the build-orchestration-awx role

## Version 0.12-000004 (devon-thyne)
### Enhancement - Addition of build-user-mfa-policy in build-REDACTED
* Created user-mfa-policy.json
* Included build-mfa-policy in 12-iam-policies

## Version 0.12-000003 (devon-thyne)
### Enhancement - IAM resource creation for Vault auto-unseal
* Created AWS KMS key to auto-unseal a HashiCorp Vault instance
* Created necessary IAM policy and attached it to the build-REDACTED role in order to enable KMS auto-unseal feature for Vault instance

## Version 0.12-000002 (devon-thyne)
### Enhancement - Git Folder relocation
* Moved underneath Environments

## Version 0.12-000001 (devon-thyne)
### Initial build-REDACTED created
* Create terraform configuration for existing Build REDACTED VPC
* Import existing infrastructure into module
* Include templated submodules for creation of build AWS account IAM resources
* Import existing build AWS account IAM resources into module
