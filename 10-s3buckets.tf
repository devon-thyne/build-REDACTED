/*
  Filename: s3buckets.tf
  Synopsis: Create S3 buckets
  Comments: N/A
*/



##### Vault S3 bucket

resource "aws_s3_bucket" "backups_vault_s3" {
    bucket = "build-backups-REDACTED"
    acl    = "private"
    tags = {
        Name = "build-backups-REDACTED"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
        Environment = ""
        Business = ""
        Account = ""
        Description = ""
        Customer = "${ var.vpc_custom_name }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}

# Access Block
resource "aws_s3_bucket_public_access_block" "vault_s3_access_block" {
    bucket = "${aws_s3_bucket.backups_vault_s3.id}"
    block_public_acls = true
    ignore_public_acls = true
    block_public_policy = true
    restrict_public_buckets = true
}


##### build-terraform-REDACTED

resource "aws_s3_bucket" "build_terraform_REDACTED_s3" {
    bucket = "build-terraform-REDACTED"
    acl    = "private"
    tags = {
        Name = "build-terraform-REDACTED"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
        Environment = ""
        Business = ""
        Account = ""
        Description = ""
        Customer = "${ var.vpc_custom_name }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}

# Access Block
resource "aws_s3_bucket_public_access_block" "build_terraform_REDACTED_s3_access_block" {
    bucket = "${aws_s3_bucket.build_terraform_REDACTED_s3.id}"
    block_public_acls = true
    ignore_public_acls = true
    block_public_policy = true
    restrict_public_buckets = true
}

