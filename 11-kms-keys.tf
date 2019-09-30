/*
  Filename: kms-keys.tf
  Synopsis: Creates KMS keys
  Description: N/A
  Comments: N/A
*/


##### KMS Keys

# Create KMS key for auto-unsealing Vault server
resource "aws_kms_key" "vault" {
    description = "Vault unseal key"
    deletion_window_in_days = 7
    tags = {
        Name = "${ var.vpc_custom_name }-vault-kms-unseal"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}

# Create an alias for KMS key for auto-unsealing Vault server
resource "aws_kms_alias" "vault" {
    name = "alias/vault-kms-unseal-key"
    target_key_id = "${ aws_kms_key.vault.key_id }"
}

