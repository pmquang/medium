# This is a example for creating VPC using module
# One in ap-southeast-1, one in us-east-1

module "internal-vpc" {

  source = "../modules/terraform-aws-vpc"

  name = "${local.vpc.internal.name}-vpc"
  cidr = local.vpc.internal.cidr

  azs             = local.vpc.internal.azs
  private_subnets = local.vpc.internal.private_subnets
  public_subnets  = local.vpc.internal.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnet_tags = {
    Type = "private"
  }

  public_subnet_tags = {
    Type = "public"
  }

  tags = merge(
    local.tags,
    {
      "Name" = local.vpc.internal.name
    },
  )
}

module "integration-vpc" {

  providers = {
    aws = aws.us-east-1
  }

  source = "../../modules/terraform-aws-vpc"

  name = "${local.vpc.integration.name}-vpc"
  cidr = local.vpc.integration.cidr

  azs             = local.vpc.integration.azs
  private_subnets = local.vpc.integration.private_subnets
  public_subnets  = local.vpc.integration.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnet_tags = {
    Type = "private"
  }

  public_subnet_tags = {
    Type = "public"
  }

  tags = merge(
    local.tags,
    {
      "Name" = local.vpc.integration.name
    },
  )
}
