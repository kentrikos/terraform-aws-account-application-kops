
# Kubernetes cluster:
module "kubernetes_cluster_application" {
  source = "github.com/kentrikos/terraform-aws-kops?ref=0.2.0"

  cluster_name_prefix = "${var.region}-${var.product_domain_name}-${var.environment_type}"
  region              = "${var.region}"
  vpc_id              = "${var.vpc_id != "" ? var.vpc_id : ""}"
  azs                 = "${join(",", var.azs)}"
  subnets             = "${join(",", var.k8s_private_subnets)}"

  node_count           = "${var.k8s_node_count}"
  master_instance_type = "${var.k8s_master_instance_type}"
  node_instance_type   = "${var.k8s_node_instance_type}"
  aws_ssh_keypair_name = "${var.k8s_aws_ssh_keypair_name}"
  linux_distro         = "${var.k8s_linux_distro}"

  masters_iam_policies_arns = "${var.k8s_masters_iam_policies_arns}"
  nodes_iam_policies_arns   = "${var.k8s_nodes_iam_policies_arns}"

  iam_cross_account_role_arn = "${var.iam_cross_account_role_arn}"
}

## Kinesis integration
#module "kinesis_vpc_endpoint" {
#  source = "FIXME"
#
#  region     = "${var.region}"
#  subnet_ids = "${module.vpc.private_subnets}"
#  tags       = "${var.tags}"
#}


#module "cross-account-kinesis-role" {
#  source = "FIXME"
#
#  role_name       = "${var.kinesis_cross_account_role_name}"
#  assume_role_arn = "${var.transit_kinesis_role_arn}"
#  trusted_roles   = "${var.advanced_account_trusted_roles}"  #TODO: output from the kubernetes module could provide these roles.
#}

