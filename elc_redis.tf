ephemeral "random_password" "redis" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}<>?"
}

resource "aws_secretsmanager_secret" "redis" {
  name = lower("${local.app_name}/redis-${var.redis_name}")
}

resource "aws_secretsmanager_secret_version" "redis" {
  secret_id = aws_secretsmanager_secret.redis.id
  secret_string_wo = jsonencode({
    USER = local.app_name,
    PASS = ephemeral.random_password.redis.result
  })
  secret_string_wo_version = 1
}

data "aws_secretsmanager_secret_version" "redis" {
  secret_id  = aws_secretsmanager_secret.redis.id
  depends_on = [aws_secretsmanager_secret_version.redis]
}

data "aws_elasticache_user" "default" {
  count   = var.create_redis ? 1 : 0
  user_id = "default"
}

resource "aws_elasticache_user" "app" {
  user_id       = local.app_name
  user_name     = local.app_name
  engine        = "redis"
  passwords     = [jsondecode(data.aws_secretsmanager_secret_version.redis.secret_string).PASS]
  access_string = "on ~* +@all"
}

resource "aws_elasticache_user_group" "add_on" {
  count         = var.create_redis ? 1 : 0
  engine        = "redis"
  user_group_id = local.redisug_name
  user_ids = [
    data.aws_elasticache_user.default[0].user_id,
    aws_elasticache_user.app.user_id
  ]
}

resource "aws_elasticache_serverless_cache" "add_on" {
  count                    = var.create_redis ? 1 : 0
  name                     = var.redis_name
  engine                   = "redis"
  subnet_ids               = var.subnets_ids
  snapshot_retention_limit = var.snapshot_retention
  security_group_ids       = [aws_security_group.redis[0].id]
  user_group_id            = aws_elasticache_user_group.add_on[0].user_group_id

  cache_usage_limits {
    data_storage {
      maximum = var.size_storage
      unit    = "GB"
    }
    ecpu_per_second {
      maximum = 5000
    }
  }
}

data "aws_elasticache_serverless_cache" "add_on" {
  count = var.create_redis ? 0 : 1
  name  = var.redis_name
}

resource "aws_elasticache_user_group_association" "add_on" {
  count         = var.create_redis ? 0 : 1
  user_group_id = local.redisug_name
  user_id       = aws_elasticache_user.app.user_id
}