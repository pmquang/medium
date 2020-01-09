## This is a example for using multiple providers

provider "aws" {
  version = "2.17.0"
  region = "ap-southeast-1"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/${var.role_arn}"
    external_id = "${var.external_id}"
  }
}

provider "aws" {
  alias = "us-east-1"
  region  = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/${var.role_arn}"
    external_id = "${var.external_id}"
  }
}
