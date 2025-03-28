# terraform-aws-elc-redis

This Terraform module provides a reusable and modular configuration for managing Redis clusters on AWS using Amazon ElastiCache. It supports both the creation of new Redis clusters and the integration of existing ones, making it flexible for various use cases.

## Features

- **Create a new Redis cluster**: Automatically provisions a Redis Serverless cluster with customizable settings.
- **Use an existing Redis cluster**: Integrates with an already existing Redis cluster by providing its name.
- **IAM Role and Policy Management**: Configures IAM roles and policies to securely access AWS Secrets Manager.
- **Dynamic Endpoint Management**: Automatically retrieves and manages Redis endpoints and ports.
- **Environment-Aware Configuration**: Supports multiple environments (e.g., dev, staging, prod) using variables.

## Usage

### Example 1: Creating a New Redis Cluster

```hcl
module "add_on_new_redis" {
  source = "."

  waypoint_application = "my-app-dev"
  create_redis         = true
  app_role_name        = "EKSMicroserviceExecutionRoleForMyApp"
  vpc_id               = "vpc-123456789"
  subnets_ids          = ["subnet-abc123", "subnet-def456"]
  source_cidrs         = ["10.0.0.0/24"]
}
```

### Example 2: Using an Existing Redis Cluster

```hcl
module "add_on_existing_redis" {
  source = "."

  waypoint_application = "my-app-dev"
  create_redis         = false
  redis_name           = "my-shared-redis"
  app_role_name        = "EKSMicroserviceExecutionRoleForMyApp"
}
```

## Module Docs

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.92.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.92.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_serverless_cache.add_on](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/resources/elasticache_serverless_cache) | resource |
| [aws_elasticache_user.app](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/resources/elasticache_user) | resource |
| [aws_elasticache_user_group.add_on](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/resources/elasticache_user_group) | resource |
| [aws_elasticache_user_group_association.add_on](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/resources/elasticache_user_group_association) | resource |
| [aws_iam_role_policy.add_on](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/resources/iam_role_policy) | resource |
| [aws_secretsmanager_secret.redis](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.redis](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.redis](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/resources/security_group) | resource |
| [aws_elasticache_serverless_cache.add_on](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/data-sources/elasticache_serverless_cache) | data source |
| [aws_elasticache_user.default](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/data-sources/elasticache_user) | data source |
| [aws_iam_role.app](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/data-sources/iam_role) | data source |
| [aws_secretsmanager_secret_version.redis](https://registry.terraform.io/providers/hashicorp/aws/5.92.0/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_role_name"></a> [app\_role\_name](#input\_app\_role\_name) | Role name to attache the new Secret Manager policy | `string` | n/a | yes |
| <a name="input_assume_role_arn"></a> [assume\_role\_arn](#input\_assume\_role\_arn) | The ARN of the role to assume by Terraform | `string` | n/a | yes |
| <a name="input_create_redis"></a> [create\_redis](#input\_create\_redis) | Create a Redis cluster or use an existing one | `bool` | n/a | yes |
| <a name="input_redis_name"></a> [redis\_name](#input\_redis\_name) | The name of the Redis cluster | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy resources | `string` | n/a | yes |
| <a name="input_size_storage"></a> [size\_storage](#input\_size\_storage) | The maximum data storage limit in the cache, expressed in Gigabytes | `number` | `10` | no |
| <a name="input_snapshot_retention"></a> [snapshot\_retention](#input\_snapshot\_retention) | The number of snapshots that will be retained for the serverless cache that is being created. As new snapshots beyond this limit are added, the oldest snapshots will be deleted on a rolling basis | `number` | `1` | no |
| <a name="input_source_cidrs"></a> [source\_cidrs](#input\_source\_cidrs) | List of CIDRs that will be allowed to access the Redis cluster | `list(string)` | n/a | yes |
| <a name="input_subnets_ids"></a> [subnets\_ids](#input\_subnets\_ids) | List of subnet IDs where the resources will be deployed | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the resources will be deployed | `string` | n/a | yes |
| <a name="input_waypoint_application"></a> [waypoint\_application](#input\_waypoint\_application) | Name of the application | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_redis_arn"></a> [redis\_arn](#output\_redis\_arn) | ARN of the Redis cluster |
| <a name="output_redis_endpoint"></a> [redis\_endpoint](#output\_redis\_endpoint) | Endpoint of the Redis cluster |
