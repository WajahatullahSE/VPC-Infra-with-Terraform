module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = var.vpc_cidr
  env_tag   = var.env_tag
}

module "subnets" {
  source          = "./modules/subnets"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  env_tag         = var.env_tag
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
  env_tag = var.env_tag
}

module "nat" {
  source           = "./modules/nat"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.subnets.public_subnet_ids[0]
  env_tag          = var.env_tag
}

module "route_tables" {
  source = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
  igw_id              = module.igw.igw_id
  nat_id              = module.nat.nat_id
  env_tag             = var.env_tag
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  env_tag = var.env_tag
}

module "ec2" {
  source            = "./modules/ec2"
  subnet_public_id  = module.subnets.public_subnet_ids[0]
  subnet_private_id = module.subnets.private_subnet_ids[0]
  key_name          = var.key_name
  instance_type     = var.instance_type
  env_tag           = var.env_tag
  ami_owner         = var.ami_owner
  public_sg_id      = module.security.public_sg_id
  private_sg_id     = module.security.private_sg_id
}

module "flowlogs" {
  source = "./modules/flowlogs"
  vpc_id = module.vpc.vpc_id
  env_tag = var.env_tag
}

module "endpoints" {
  source = "./modules/endpoints"
  vpc_id            = module.vpc.vpc_id
  route_table_ids   = module.route_tables.private_route_table_ids
  env_tag           = var.env_tag
}

