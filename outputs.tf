output "redis_endpoint" {
  value       = local.redis_endpoint
  description = "Endpoint of the Redis cluster"
}

output "redis_arn" {
  value       = local.redis_arn
  description = "ARN of the Redis cluster"
}