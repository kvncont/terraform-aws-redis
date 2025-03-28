locals {
  app_name               = regex("(.*)-[^-]+$", var.waypoint_application)[0]
  env                    = split("-", var.waypoint_application)[length(split("-", var.waypoint_application)) - 1]
  redis_name             = var.create_redis ? local.app_name : var.redis_name
  redisug_name           = "${var.redis_name}-redisug"
  redis_endpoint_address = var.create_redis ? aws_elasticache_serverless_cache.add_on[0].endpoint[0].address : data.aws_elasticache_serverless_cache.add_on[0].endpoint.address
  redis_endpoint_port    = var.create_redis ? aws_elasticache_serverless_cache.add_on[0].endpoint[0].port : data.aws_elasticache_serverless_cache.add_on[0].endpoint.port
  redis_endpoint         = "${local.redis_endpoint_address}:${local.redis_endpoint_port}"
  redis_arn              = var.create_redis ? aws_elasticache_serverless_cache.add_on[0].arn : data.aws_elasticache_serverless_cache.add_on[0].arn
}