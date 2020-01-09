# This is a example config for Terraform.

data "external" "account_id" {
  program = ["bash", "${path.module}/data/scripts/get_account_id.sh"]
}

locals {

  account_id = "${data.external.account_id.result.account_id}"

  env = "dev"
  region = "ap-southeast-1"
  project = "internal"

  vpc = {
    internal = {
      name = "${local.env}-${local.region}-${local.project}-vpc"
      cidr = "10.0.0.0/16"
      azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
      private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    }
  }

  tags = {
    Owner = "quangpm"
    Environment   = "dev"
    Project = local.project
    Terraform   = "true"
  }
}

variable "role_arn" {
  description = "Export your TF_VAR_role_arn to run terraform"
  type        = string
  default     = "xxxxxxxxxxxx"
}

variable "external_id" {
  description = "Export your TF_VAR_external_id to run terraform"
  type        = string
  default     = "xxxxxxxxxxxx"
}

variable "dev_workstation_ssh_public_key" {
  description = "Dev workstation ssh public key"
  type        = string
  default     = "xxxxxxxxxxxx"
}

variable "gpg_public_key_base64" {
  description = "GPG key"
  type        = string
  default     = "xxxxxxxxxxxx"
}

terraform {
  required_version = "=0.12.8"
  backend "s3" {
    bucket         = "terraform-state.example.io"
    key            = "dev/internal/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = "true"
  }
}
