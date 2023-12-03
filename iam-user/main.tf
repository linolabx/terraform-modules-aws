terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }
}

variable "name" {
  type        = string
  description = "username"
}

variable "groups" {
  type        = list(string)
  description = "groups to attach to user"
}

variable "create_access_key" {
  type        = bool
  description = "create access key for user"
  default     = false
}

variable "create_login_profile" {
  type        = bool
  description = "create login profile for user"
  default     = false
}

resource "aws_iam_user" "this" { name = var.name }

resource "aws_iam_user_group_membership" "this" {
  user   = aws_iam_user.this.name
  groups = var.groups
}

resource "aws_iam_user_login_profile" "this" {
  count                   = var.create_login_profile ? 1 : 0
  user                    = aws_iam_user.this.name
  password_reset_required = false
}

resource "aws_iam_access_key" "this" {
  count = var.create_access_key ? 1 : 0
  user  = aws_iam_user.this.name
}

output "name" { value = aws_iam_user.this.name }
output "arn" { value = aws_iam_user.this.arn }
output "access_key" { value = var.create_access_key ? aws_iam_access_key.this[0].id : null }
output "secret_key" {
  value     = var.create_access_key ? aws_iam_access_key.this[0].secret : null
  sensitive = true
}
output "password" {
  value     = var.create_login_profile ? aws_iam_user_login_profile.this[0].password : null
  sensitive = true
}
