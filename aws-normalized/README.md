# aws-normalized

This module creates missing resources in other aws partitions.

```tf
module "normalized" { source = "github.com/linolabx/terraform-modules-aws//aws-normalized" }
```

aws-cn missing resource list:

- `policy/IAMSelfManageServiceSpecificCredentials`
