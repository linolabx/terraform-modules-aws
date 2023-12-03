terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }
}

module "normalized" {
  providers = { aws = aws.this }
  source    = "github.com/linolabx/terraform-modules-aws//aws-normalized"
}
