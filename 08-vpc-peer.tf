/*
  Filename: vpc-peer.tf
  Synopsis: VPC peering to other VPCs
  Comments: N/A
*/


# Peer build-REDACTED VPC with default build VPC
resource "aws_vpc_peering_connection" "default_build_peer" {
    vpc_id = "${ data.aws_vpc.default_build.id }"
    peer_vpc_id = "${ aws_vpc.vpc.id }"
    auto_accept = true
    tags = {
        Name = "${ data.aws_vpc.default_build.tags.Name }"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}

