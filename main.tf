# VPC for Kubernetes cluster:
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  create_vpc          = "${var.vpc_id != "" ? false : true}"

  name                = "${var.product_domain_name}-${var.environment_type}"

  reuse_nat_ips       = "${length(var.new_vpc_elastic_ips) == 0 ? false : true}"     
  external_nat_ip_ids = ["${var.new_vpc_elastic_ips}"]
  cidr                = "${var.new_vpc_cidr}"
  azs  = "${var.azs}"
  public_subnets      = "${var.new_vpc_public_subnets}"
  private_subnets     = "${var.new_vpc_private_subnets}"
  enable_nat_gateway     = true                                                 
  single_nat_gateway     = false                                                
  one_nat_gateway_per_az = true                                                 

  tags = {                                                                      
    Terraform   = "true"                                                        
    Project     = "${var.project_name}"                                         
    Environment = "${var.project_environment}"                                  
  }                                                                             
}

# Kubernetes cluster:
module "kubernetes_cluster_application" {
  source = "https://github.com/kentrikos/terraform-aws-kops.git" 

  cluster_name_prefix        = "${var.product_domain_name}-${var.environment_type}"
  region                     = "${var.region}"
  vpc_id                     = "${var.vpc_id != "" ? var.vpc_id : module.vpc.vpc_id}"
  azs                        = "${join(",", var.azs)}"
  subnets                    = "${join(",", var.k8s_private_subnets)}"
  node_count                 = "${var.k8s_node_count}"
  iam_cross_account_role_arn = "arn:aws:iam::${var.application_aws_account_number}:role/kops-management-node-${var.product_domain_name}-${var.environment_type}.k8s.local"
}

# Kinesis integration
module "kinesis_vpc_endpoint" {
  source = "https://github.com/kentrikos/terraform-aws-logging.git"

  region     = "${var.region}"
  subnet_ids = "${module.vpc.private_subnets}"
  tags       = "${var.tags}"
}

module "cross-account-kinesis-role" {
  source = "https://github.com/kentrikos/tf-aws-cross-account-assume-role.git"  #UPDATE_ME: with repo name for github given FIXME: this needs to be integrated with IAM generating/handling.

  role_name       = "${var.kinesis_cross_account_role_name}"
  assume_role_arn = "${var.transit_kinesis_role_arn}"
  trusted_roles   = "${var.advanced_account_trusted_roles}"  #TODO: output from the kubernetes module could provide these roles.
}
