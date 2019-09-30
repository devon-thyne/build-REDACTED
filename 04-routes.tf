/*
  Filename: routes.tf
  Synopsis: Create routes for the VPC
  Comments: N/A
*/


##### Default Route Table

# Tag default route table with name
resource "aws_default_route_table" "default_route_table" {
    default_route_table_id = "${ aws_vpc.vpc.default_route_table_id }"
    tags = {
        Name = "${ var.vpc_custom_name }-default-route"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }
}

# Route all traffic in default route table to internet gateway
resource "aws_route" "default_route_internet_gateway" {
    route_table_id = "${ aws_vpc.vpc.default_route_table_id }"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_internet_gateway.internet_gateway.id }"
}

# Route build to management
resource "aws_route" "default_route_build_peer" {
    route_table_id = "${ aws_vpc.vpc.default_route_table_id }"
    destination_cidr_block = "${ data.aws_vpc.default_build.cidr_block }"
    vpc_peering_connection_id = "${ aws_vpc_peering_connection.default_build_peer.id }"
}
