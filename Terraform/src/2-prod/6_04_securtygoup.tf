
module "security_group_LB" {
  source = "../modules/security_group"

  name   = var.name
  vpc_id = module.vpc_config.id

  rules = {
    ingress = {
      ddb = {
        cidr_blocks = ["10.0.0.0/16"]
        to_port     = 5432
        from_port   = 5432
        protocol    = "tcp"
        description = "Permite el ingreso unicamente desde la VPC a la que pertenece el SG"
      }
    }
    egress = {
      all = {
        cidr_blocks = [""] #Aca colocamos elbloque CIDR del EKS 
        to_port     = 65535
        from_port   = 0
        protocol    = "tcp"
        description = "Permite el egreso a cualquier destino"
      }
    }
    tags = var.tags
  }
}

resource "aws_security_group" "cluster" {
  name        = "${var.name}-cluster-sg"
  description = "Security group para el control plane de EKS"
  vpc_id      = module.vpc_config.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-cluster-sg"
  })
}

resource "aws_security_group_rule" "cluster_ingress_nodes" {
  description              = "Permitir comunicación desde los nodos"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.nodes.id
}

resource "aws_security_group" "nodes" {
  name        = "${var.name}-nodes-sg"
  description = "Security group para los nodos de EKS"
  vpc_id      = module.vpc_config.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name                                        = "${var.name}-nodes-sg"
    "kubernetes.io/cluster/${var.name}" = "owned"
  })
}

resource "aws_security_group_rule" "nodes_ingress_self" {
  description              = "Comunicación entre nodos"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes.id
  source_security_group_id = aws_security_group.nodes.id
}

resource "aws_security_group_rule" "nodes_ingress_cluster" {
  description              = "Tráfico desde el control plane a los nodos"
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nodes.id
  source_security_group_id = aws_security_group.cluster.id
}

resource "aws_security_group_rule" "nodes_ingress_cluster_https" {
  description              = "HTTPS desde el control plane a los nodos"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nodes.id
  source_security_group_id = aws_security_group.cluster.id
}
