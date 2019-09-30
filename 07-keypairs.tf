/*
  Filename: keypairs.tf
  Synopsis: VPC Key Pairs
  Comments: N/A
*/


##### Upload key pairs only if conditional flag (var.key_pairs) is set to true. Default is false.

resource "aws_key_pair" "build_REDACTED_key_pair" {
    count = "${ var.aws_keypair ? 1 : 0 }"
    key_name = "build-development"
    public_key = "${ var.build_REDACTED_public_key }"
    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_key_pair" "build_REDACTED_key_pair" {
    count = "${ var.aws_keypair ? 1 : 0 }"
    key_name = "build-REDACTED"
    public_key = "${ var.build_REDACTED_public_key }"
    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_key_pair" "build_REDACTED_key_pair" {
    count = "${ var.aws_keypair ? 1 : 0 }"
    key_name = "build-REDACTED"
    public_key = "${ var.build_REDACTED_public_key }"
    lifecycle {
    #    prevent_destroy = true
    }
}

