module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name  = "iti-vpc"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
  subnet_cidrs_prv = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  subnet_cidrs_pup = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.subnets.subnet_ids_pup
}

module "SG" {
  source = "./modules/SG"
  vpc_id = module.vpc.vpc_id
  control_plane_cidr_blocks = ["10.0.0.0/16"]
}

module "IAM-Role" {
  source = "./modules/IAM-Role"
  role_name = "eks-role"
}

module "node-role" {
  source = "./modules/node-role"
  role_name = "project-nodes-role"
}

module "eks-cluster" {
  source = "./modules/eks-cluster"
  cluster_name = "project"
  cluster_role_arn = module.IAM-Role.role_arn
  subnet_ids = concat(
    module.subnets.subnet_ids_prv, 
    module.subnets.subnet_ids_pup
  )
  cluster_role_policy_attachment_depends_on = [
    module.IAM-Role
  ]
}

module "nodes-group" {
  source = "./modules/nodes-group"
  cluster_name = module.eks-cluster.cluster_name
  node_group_name = "project-nodes"
  node_role_arn = module.node-role.role_arn
  subnet_ids = module.subnets.subnet_ids_prv
  desired_size    = 2
  max_size        = 3
  min_size        = 1
  max_unavailable = 1
  instance_types  = ["t3.medium"]
  ami_type        = "AL2_x86_64"
  depends_on_resources = [
    module.node-role.role_arn
  ]   
}
