variable "product_domain_name" {
  description = "Name of product domain (e.g. maps)"
}

variable "environment_type" {
  description = "Type of environment (e.g. test, int, e2e, prod)"
}

variable "vpc_id" {
  description = "ID of existing VPC where cluster will be deployed (if not specified new VPC will be created"
}

variable "new_vpc_cidr" {
  description = "CIDR range for VPC."
  default     = ""
}

variable "new_vpc_private_subnets" {
  description = "(Optional) A list of private subnets expressed in CIDR notation. This list size must match the list size of availability zones."
  type        = "list"
  default     = []
}

variable "new_vpc_public_subnets" {
  description = "(Optional) A list of public subnets expressed in CIDR notation. This list size must match the list size of availability zones."
  type        = "list"
  default     = []
}

variable "new_vpc_elastic_ips" {
  description = "(Optional) A list of existing elastic ip addresses to assign to the VPC"
  type        = "list"
  default     = []
}

variable "region" {
  description = "AWS region"
}

variable "azs" {
  description = "Availability Zones for the cluster (1 master per AZ will be deployed)"
  type        = "list"
}

variable "k8s_private_subnets" {
  description = "List of private subnets (matching AZs) where to deploy the cluster (required if existing VPC is used)"
  type        = "list"
}

variable "k8s_node_count" {
  description = "Number of worker nodes in Kubernetes cluster"
  default     = "1"
}

variable "k8s_master_instance_type" {
  description = "Instance type (size) for master nodes"
  default     = "m4.large"
}

variable "k8s_node_instance_type" {
  description = "Instance type (size) for worker nodes"
  default     = "m4.large"
}

variable "iam_cross_account_role_arn" {
  description = "Cross-account role to assume before deploying the cluster"
}

variable "k8s_masters_iam_policies_arns" {
  description = "List of existing IAM policies that will be attached to instance profile for master nodes (EC2 instances)"
  type        = "list"
}

variable "k8s_nodes_iam_policies_arns" {
  description = "List of existing IAM policies that will be attached to instance profile for worker nodes (EC2 instances)"
  type        = "list"
}

variable "k8s_aws_ssh_keypair_name" {
  description = "Optional name of existing SSH keypair on AWS account, to be used for cluster instances (will be generated if not specified)"
  default     = ""
}

variable "k8s_linux_distro" {
  description = "Linux distribution for K8s cluster instances (supported values: debian, amzn2)"
  default     = "debian"
}
