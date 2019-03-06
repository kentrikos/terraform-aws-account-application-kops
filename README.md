# A Terraform module to create "application" type of environment.

This module will create an environment suitable for "application" type of AWS account.
Most important elements of the environment:

* VPC (module can create a new one or use existing one if vpc_id is passed as a parameter)
* Kubernetes cluster

# Notes

# Usage

## Create new VPC:
* to be tested/improved

## Use existing VPC in application account:
```hcl
module "application" {                                                          
  source = "github.com/kentrikos/terraform-aws-account-application"

  product_domain_name              = "${var.product_domain_name}"
  environment_type                 = "${var.environment_type}"

  region                           = "${var.region}"
  azs                              = "${var.azs}"
  vpc_id                           = "${var.vpc_id}"
  k8s_private_subnets              = "${var.k8s_private_subnets}"

  k8s_node_count                   = "${var.k8s_node_count}"
  k8s_master_instance_type         = "${var.k8s_master_instance_type}"
  k8s_node_instance_type           = "${var.k8s_node_instance_type}"

  iam_cross_account_role_arn       = "${var.iam_cross_account_role_arn}"
  k8s_masters_iam_policies_arns    = "${var.k8s_masters_iam_policies_arns}"
  k8s_nodes_iam_policies_arns      = "${var.k8s_nodes_iam_policies_arns}"

}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| product\_domain\_name | Name of product domain (e.g. maps) | string | n/a | yes |
| environment\_type | Type of environment (e.g. test, int, e2e, prod) | string | n/a | yes |
| vpc\_id | ID of existing VPC where cluster will be deployed (if not specified new VPC will be created | string | n/a | yes |
| new\_vpc\_cidr | CIDR range for VPC. | string | `""` | no |
| new\_vpc\_private\_subnets | (Optional) A list of private subnets expressed in CIDR notation. This list size must match the list size of availability zones. | list | `<list>` | no |
| new\_vpc\_public\_subnets | (Optional) A list of public subnets expressed in CIDR notation. This list size must match the list size of availability zones. | list | `<list>` | no |
| new\_vpc\_elastic\_ips | (Optional) A list of existing elastic ip addresses to assign to the VPC | list | `<list>` | no |
| region | AWS region | string | n/a | yes |
| azs | Availability Zones for the cluster (1 master per AZ will be deployed) | list | n/a | yes |
| k8s\_private\_subnets | List of private subnets (matching AZs) where to deploy the cluster (required if existing VPC is used) | list | n/a | yes |
| k8s\_node\_count | Number of worker nodes in Kubernetes cluster | string | `"1"` | no |
| k8s\_master\_instance\_type | Instance type (size) for master nodes | string | `"m4.large"` | no |
| k8s\_node\_instance\_type | Instance type (size) for worker nodes | string | `"m4.large"` | no |
| iam\_cross\_account\_role\_arn | Cross-account role to assume before deploying the cluster | string | n/a | yes |
| k8s\_masters\_iam\_policies\_arns | List of existing IAM policies that will be attached to instance profile for master nodes (EC2 instances) | list | n/a | yes |
| k8s\_nodes\_iam\_policies\_arns | List of existing IAM policies that will be attached to instance profile for worker nodes (EC2 instances) | list | n/a | yes |
| k8s\_aws\_ssh\_keypair\_name | Optional name of existing SSH keypair on AWS account, to be used for cluster instances (will be generated if not specified) | string | `""` | no |
| k8s_linux_distro | Linux distribution for K8s cluster instances (supported values: debian, amzn2) | string | `debian` | no |
