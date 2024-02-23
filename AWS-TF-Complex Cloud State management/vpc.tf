module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC_NAME
  cidr = var.VPC_CIDR

  azs             = [var.AZ1, var.AZ2, var.AZ3]
  public_subnets  = [var.PublicSubnet1, var.PublicSubnet2, var.PublicSubnet3]
  private_subnets = [var.PrivateSubnet1, var.PrivateSubnet2, var.PrivateSubnet3]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "Prod"
  }
  vpc_tags = {
    Name = var.VPC_NAME
  }
}
