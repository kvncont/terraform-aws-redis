variable "region" {
  type        = string
  description = "The AWS region to deploy resources"
}

variable "assume_role_arn" {
  type        = string
  description = "The ARN of the role to assume by Terraform"
}

variable "waypoint_application" {
  type        = string
  description = "Name of the application"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*-(poc|dev|test|qa|stg|pre|pro)$", var.waypoint_application))
    error_message = "The waypoint_application variable must start with a lowercase letter, can only contain lowercase letters, numbers, and hyphens (-), and must end with one of the following suffixes: poc, dev, test, qa, stg, pre, pro."
  }
}

variable "app_role_name" {
  type        = string
  description = "Role name to attache the new Secret Manager policy"
}

variable "create_redis" {
  type        = bool
  description = "Create a Redis cluster or use an existing one"
}

variable "redis_name" {
  type        = string
  description = "The name of the Redis cluster"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the resources will be deployed"
}

variable "subnets_ids" {
  description = "List of subnet IDs where the resources will be deployed"
  type        = string
}

variable "source_cidrs" {
  type        = string
  description = "List of CIDRs that will be allowed to access the Redis cluster"
}

variable "snapshot_retention" {
  type        = number
  description = "The number of snapshots that will be retained for the serverless cache that is being created. As new snapshots beyond this limit are added, the oldest snapshots will be deleted on a rolling basis"
}

variable "size_storage" {
  description = "The maximum data storage limit in the cache, expressed in Gigabytes"
  type        = number
}
