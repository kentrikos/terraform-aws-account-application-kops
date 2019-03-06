locals {
  cluster_name = "${var.region}-${var.product_domain_name}-${var.environment_type}"

  common_tags = {
    Terraform         = true
    ProductDomainName = "${var.product_domain_name}"
    EnvironmentType   = "${var.environment_type}"
    Cluster           = "${local.cluster_name}"
  }
}

# VPC for Kubernetes cluster:
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  create_vpc = "${var.vpc_id != "" ? false : true}"

  name = "${var.product_domain_name}-${var.environment_type}"

  reuse_nat_ips          = "${length(var.new_vpc_elastic_ips) == 0 ? false : true}"
  external_nat_ip_ids    = ["${var.new_vpc_elastic_ips}"]
  cidr                   = "${var.new_vpc_cidr}"
  azs                    = "${var.azs}"
  public_subnets         = "${var.new_vpc_public_subnets}"
  private_subnets        = "${var.new_vpc_private_subnets}"
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  tags = "${local.common_tags}"
}

# Kubernetes cluster:
module "kubernetes_cluster_application" {
  source = "github.com/kentrikos/terraform-aws-eks?ref=0.2.0"

  cluster_prefix            = "${local.cluster_name}"
  region                    = "${var.region}"
  vpc_id                    = "${var.vpc_id != "" ? var.vpc_id : module.vpc.vpc_id}"
  private_subnets           = "${var.k8s_private_subnets}"
  desired_worker_nodes      = "${var.k8s_node_count}"
  worker_node_instance_type = "${var.k8s_node_instance_type}"
  key_name                  = "${var.k8s_aws_ssh_keypair_name}"

  tags = "${local.common_tags}"
}
