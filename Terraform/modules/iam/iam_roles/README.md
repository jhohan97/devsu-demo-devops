
### Example of Module Usage

```terraform
module "iam_role_eks" {
  source = ""
  common_config = {
    name        = var.name
    environment = var.environment
    tags        = var.tags
  }

  role_config = {

    "eks" = {
      resource_number = var.resource_number
      description     = "Enable EKS Permissions ${var.name} role 01"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]
      statements = [
        {
          Sid    = "enableRolEKS"
          Effect = "Allow"
          Principal = {
            Service = var.eks-principal
          }
          Action = ["sts:AssumeRole"]
        }
      ]
    }

    "nodes" = {
      resource_number = var.resource_number
      description     = "Enable EC2 Permissions ${var.name} role 02"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        module.iam_policy.arn["eks"]
      ]
      statements = [
        {
          Sid    = "enableRolEKS"
          Effect = "Allow"
          Principal = {
            Service = var.ec2-principal
          }
          Action = ["sts:AssumeRole"]
        }
      ]
    }
  }
}
