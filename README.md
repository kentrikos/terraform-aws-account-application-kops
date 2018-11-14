# A Terraform module to create "application" type of environment.


This module will create an environment suitable for "application" type of AWS account.
Most important elements of the environment:

* VPC (module can create a new one or use existing one if vpc_id is passed as a parameter)
* Kubernetes cluster
* VPC Endpoint (Interface) - kinesis streams service


# Usage

## Create new VPC:
TBD (needs tests/fixes)

## Use existing VPC in application account:
```hcl
module "application" {
  source = "https://github.com/kentrikos/terraform-aws-account-application.git"

  region              = "${var.region}"
  azs                 = "${var.azs}"
  vpc_id              = "${var.vpc_id}"
  product_domain_name = "${var.product_domain_name}"
  product_environment = "${var.product_environment}"
  k8s_private_subnets = "${var.k8s_private_subnets}"
  k8s_node_count      = "${var.k8s_node_count}"
  transit_kinesis_role_arn  = "${var.transit_kinesis_role_arn}"
  kinesis_cross_account_role_name  = "${var.kinesis_cross_account_role_name}"
  advanced_account_trusted_roles  = "${var.advanced_account_trusted_roles}"
  iam_cross_account_role  = "${var.cross_account_role}"
}
```

# Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| advanced_account_trusted_roles | - | list | - | yes |
| application_aws_account_number | AWS application account number (without hyphens) | string | - | yes |
| azs | Availability Zones for the cluster (1 master per AZ will be deployed) | list | - | yes |
| environment_type | Type of environment (e.g. test, int, e2e, prod) | string | - | yes |
| iam_cross_account_role_arn | Cross-account role to assume before deploying the cluster | string | - | yes |
| k8s_node_count | Number of worker nodes in Kubernetes cluster | string | `1` | no |
| k8s_private_subnets | List of private subnets (matching AZs) where to deploy the cluster (required if existing VPC is used) | list | - | yes |
| kinesis_cross_account_role_name | - | string | - | yes |
| new_vpc_cidr | CIDR range for VPC. | string | - | yes |
| new_vpc_elastic_ips | (Optional) A list of existing elastic ip addresses to assign to the VPC | list | `<list>` | no |
| new_vpc_private_subnets | (Optional) A list of private subnets expressed in CIDR notation. This list size must match the list size of availability zones. | list | - | yes |
| new_vpc_public_subnets | (Optional) A list of public subnets expressed in CIDR notation. This list size must match the list size of availability zones. | list | - | yes |
| product_domain_name | Name of product domain (e.g. maps) | string | - | yes |
| project_environment | - | string | - | yes |
| project_name | - | string | - | yes |
| region | AWS region | string | `eu-central-1` | no |
| tags | - | map | `<map>` | no |
| transit_kinesis_role_arn | - | string | - | yes |
| vpc_id | ID of existing VPC where cluster will be deployed (if not specified new VPC will be created | string | - | yes |

