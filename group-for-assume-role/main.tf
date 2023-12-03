terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }
}

variable "name_suffix" {
  type        = string
  description = "group name prefix"
}

variable "roles" {
  type        = list(string)
  default     = []
  description = "roles that group user can assume"
}

variable "role_arns" {
  type        = list(string)
  default     = []
  description = "role ARNs that group user can assume, used for assume role from another account"
}

data "aws_partition" "this" {}
data "aws_caller_identity" "this" {}

locals {
  role_arns = concat(
    [for role in var.roles : "arn:${data.aws_partition.this.partition}:iam::${data.aws_caller_identity.this.account_id}:role/${role}"],
    var.role_arns
  )
  group_name = "AssumeRole-${var.name_suffix}-${random_pet.this.id}"
}


resource "random_pet" "this" {}
resource "aws_iam_group" "this" { name = local.group_name }

resource "aws_iam_policy" "assume_role" {
  count = length(local.role_arns) > 0 ? 1 : 0

  name = local.group_name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = "sts:AssumeRole",
      Effect   = "Allow",
      Resource = [for role in var.roles : "arn:${data.aws_partition.this.partition}:iam::${data.aws_caller_identity.this.account_id}:role/${role}"]
    }]
  })
}

resource "aws_iam_group_policy_attachment" "assume_role" {
  count = length(local.role_arns) > 0 ? 1 : 0

  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.assume_role.arn
}

output "group_name" { value = aws_iam_group.this.name }
output "group_arn" { value = aws_iam_group.this.arn }
