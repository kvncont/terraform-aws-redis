variable "region" {
  type = string
  description = "The AWS region to deploy resources"
}

variable "assume_role_arn" {
  type = string
  description = "The ARN of the role to assume by Terraform"
}