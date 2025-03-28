resource "aws_security_group" "redis" {
  count       = var.create_redis ? 1 : 0
  name        = lower("${local.redis_name}-sg")
  description = "Security group for Redis"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = split(",", replace(var.source_cidrs, " ", ""))
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}