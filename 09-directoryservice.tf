/*
  Filename: directoryservice.tf
  Synopsis: This will setup AWS Directory Services
  Comments: Requires two subnets in different availability zones
*/


resource "aws_directory_service_directory" "directory_service" {
    name = "${ var.ds_fqdn }"
    short_name = "${ var.ds_netbios }"
    password = "${ var.ds_admin_password }"
    edition = "Standard"
    type = "MicrosoftAD"
#    description = "Directory Service for ${ var.vpc_custom_name }"
    tags = {
        Name = "${ var.vpc_custom_name }-DirectoryService"
        Generated-By = "Terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
    }
    lifecycle {
        ignore_changes = ["tags"]
    }

    vpc_settings {
        vpc_id = "${ aws_vpc.vpc.id }"
        subnet_ids = [
            "${ aws_subnet.subnet_private_1a.id }", 
            "${ aws_subnet.subnet_private_1b.id }" 
        ]
    }
}

