terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module account_role {
    count = var.create_account_roles ? 1 : 0
    source = "./account_roles"
    redhat_aws_account_id = var.redhat_aws_account_id
    rosa_openshift_version = var.rosa_openshift_version
}
