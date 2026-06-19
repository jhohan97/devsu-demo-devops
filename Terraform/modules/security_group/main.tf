
resource "aws_security_group" "sg" {
  
  name   = "${var.name}-${var.environment}-${format("%02d", var.resource_number)}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.rules.ingress != null ? var.rules.ingress : {}
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      description     = ingress.value.description
      security_groups = ingress.value.source_sg
    }
  }

  dynamic "egress" {
    for_each = var.rules.egress != null ? var.rules.egress : {}
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  tags = merge(
    var.tags,
    {
      "Name"       = "sg-${var.name}-${var.environment}-${format("%02d", var.resource_number)}"
      "managed-by" = "Terraform"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}