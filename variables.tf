variable "product_domain_name" {
  description = "Name of product domain (e.g. maps)"
}

variable "environment_type" {
  description = "Type of environment (e.g. test, int, e2e, prod)"
}

variable "application_aws_account_number" {
  description = "AWS application account number (without hyphens)"
}

variable "vpc_id" {
  description = "ID of existing VPC where cluster will be deployed (if not specified new VPC will be created"
}

variable "new_vpc_cidr" {
   description = "CIDR range for VPC."
}

variable "new_vpc_private_subnets" {
  description = "(Optional) A list of private subnets expressed in CIDR notation. This list size must match the list size of availability zones."
  type        = "list"
}

variable "new_vpc_public_subnets" {
  description = "(Optional) A list of public subnets expressed in CIDR notation. This list size must match the list size of availability zones."
  type        = "list"
}

variable "new_vpc_elastic_ips" {
  description = "(Optional) A list of existing elastic ip addresses to assign to the VPC"
  type    = "list"
  default = []
}

variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
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

variable "advanced_account_trusted_roles" {
  type = "list"
}

variable "iam_cross_account_role_arn" {
  description = "Cross-account role to assume before deploying the cluster"
}

variable "kinesis_cross_account_role_name" {}
variable "project_environment" {}
variable "project_name" {}

variable "tags" {
  type    = "map"
  default = {}
}

variable "transit_kinesis_role_arn" {}
