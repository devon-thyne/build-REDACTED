/*
  Filename: instances.tf
  Synopsis: Spin up VPC Instances
*/



##### Collect AMIs

# Find the latest RHEL 7.6 Base image
data "aws_ami" "rhel7_6" {
    most_recent = true
    filter {
        name = "name"
        values = ["REDACTED"]
    }
    owners = ["REDACTED"] # Owned by Bob
}

# Find the latest Green RHEL 7.6 image
data "aws_ami" "green7_6" {
    most_recent = true
    filter {
        name = "name"
        values = ["REDACTED"]
    }
    owners = ["REDACTED"] # Owned by Bob
}

# Find the latest Green RHEL 6.10 image
data "aws_ami" "green6_10" {
    most_recent = true
    filter {
        name = "name"
        values = ["REDACTED"]
    }
    owners = ["REDACTED"] # Owned by Bob
}



##### Spin up instances only if conditional flag (var.instances) is set to true. Default is false.

resource "aws_instance" "instance_patch_green7_6" {
    count = "${ var.aws_instances ? 1 : 0 }"
    ami = "${ data.aws_ami.green7_6.image_id }"
    instance_type = "t3.micro"
    tags = {
        Name = "patch/"
        Generated-By = "terraform"
        ProvisionDate = "${ timestamp() }"
        BuildUser = "${ var.build_user }"
        Business: "REDACTED"
        Platform: "unlicensed"
        Account: ""
        OperatingSystem: "RHEL 7.6"
        Image: "${ data.aws_ami.green7_6.name }"
        Domain: ""
        Environment: ""
        Hostname: ""
        ProductName: ""
        PatchGroup: ""
    }
    vpc_security_group_ids = [
        "${aws_security_group.security_group_vpc.id}",
        "${aws_security_group.security_group_egress.id}",
        "${aws_security_group.security_group_access_REDACTED.id}",
        "${aws_security_group.security_group_build.id}"
    ]
    subnet_id = "${ aws_subnet.subnet_private_1a.id }"
    key_name = "build-REDACTED"
    associate_public_ip_address = true
    iam_instance_profile = "${ module.patch_iam_role.instance_profile_id }"
    disable_api_termination = true
    lifecycle {
        ignore_changes = ["ami","tags"]
        prevent_destroy = false
    }
}



# RHEL 7.6 Vault Instance
module "instance_vault" {
  source = "../../modules/aws-instance"

  instance_map = {
    name                          = "vault"
    search_ami_name               = "REDACTED"
    owner_id                      = "REDACTED"
    instance_type                 = "t3.micro"
    ec2_key                       = "build-REDACTED"
    associate_public_ip_address   = "true"
    associate_elastic_ip_address  = "true"
    disable_api_termination       = "true"
    security_group_ids            = "${ aws_security_group.security_group_vpc.id },${ aws_security_group.security_group_egress.id },${ aws_security_group.security_group_access_REDACTED.id },${ aws_security_group.security_group_public_ingress.id }"
    subnet_id                     = "${ aws_subnet.subnet_private_1a.id }"
    iam_instance_profile          = "${ module.vault_iam_role.instance_profile_id }"
    tag_description               = ""
    tag_business                  = "REDACTED"
    tag_os                        = "RHEL 7.6"
    tag_productname               = "vault"
    tag_managedby                 = "ansible"
    tag_landscape                 = ""
    tag_patchgroup                = ""
  }

  aws_region        = "${ var.aws_region }"
  build_user        = "${ var.build_user }"
  git_name          = "${ var.git_name }"
  git_token         = "${ var.git_token }"
  module_dependency = join(",",[])
}



# RHEL 7.6 Cron Instance
module "instance_cron" {
  source = "../../modules/aws-instance"

  instance_map = {
    name                          = "cron"
    search_ami_name               = "REDACTED"
    owner_id                      = "REDACTED"
    instance_type                 = "t3.micro"
    ec2_key                       = "build-REDACTED"
    associate_public_ip_address   = "true"
    disable_api_termination       = "true"
    security_group_ids            = "${ aws_security_group.security_group_vpc.id },${ aws_security_group.security_group_egress.id },${ aws_security_group.security_group_access_REDACTED.id }"
    subnet_id                     = "${ aws_subnet.subnet_private_1a.id }"
    iam_instance_profile          = "${ module.default_iam_role.instance_profile_id }"
    tag_description               = "cronbox dedicated scheduled automation and environment cleanup"
    tag_business                  = "REDACTED"
    tag_os                        = "RHEL 7.6"
    tag_productname               = "cron"
    tag_managedby                 = "ansible"
    tag_landscape                 = ""
    tag_patchgroup                = ""
  }

  aws_region        = "${ var.aws_region }"
  build_user        = "${ var.build_user }"
  git_name          = "${ var.git_name }"
  git_token         = "${ var.git_token }"
  module_dependency = join(",",[])
}

