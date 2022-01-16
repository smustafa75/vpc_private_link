provider "aws" {
  region = var.aws_region
}

module "network" {
  source        = "./network"
  vpc_cidr      = var.vpc_cidr
  private_subnets = var.private_subnets
}

module "storage" {
  source       = "./storage"
  project_name = var.project_name
}

module "compute" {
  source                 = "./compute"
  instance_type          = var.instance_type
  instance_count         = var.instance_count
  private_subnets        = module.network.private_subnets
  private_security_group = module.network.private_security_group
  instance_profile       = module.iam.iam_instance_profile_arn
  depends_on = [
    module.iam.iam_instance_profile_arn
  ]
}

module "iam" {
  source      = "./iam"
  policy_name = var.policy_name
  s3_policy   = var.s3_policy
  role_name   = var.role_name
}