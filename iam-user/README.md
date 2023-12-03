# iam-user

create role to trust another account (so that account can assume role)

```tf
module "iam-user-linus" {
  source = "github.com/linolabx/terraform-modules-aws//iam-user"

  providers = { aws = aws.primary }

  name                 = "linus"
  groups               = ["ManagerGroup"]
  create_access_key    = true
  create_login_profile = true
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.29.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_login_profile.this](https://registry.terraform.io/providers/hashicorp/aws/5.29.0/docs/resources/iam_user_login_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_access_key"></a> [create\_access\_key](#input\_create\_access\_key) | create access key for user | `bool` | `false` | no |
| <a name="input_create_login_profile"></a> [create\_login\_profile](#input\_create\_login\_profile) | create login profile for user | `bool` | `false` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | groups to attach to user | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | username | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key"></a> [access\_key](#output\_access\_key) | n/a |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_secret_key"></a> [secret\_key](#output\_secret\_key) | n/a |
