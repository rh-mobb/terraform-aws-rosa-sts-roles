resource "aws_iam_role" "ocm_role" {
  count = length(var.ocm_orgs)
  name = "ManagedOpenShift-OCM-Role-${var.ocm_orgs[count.index].external_id}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Condition = {
            StringEquals = {                
                "sts:ExternalId" = var.ocm_orgs[count.index].external_id
            }
        }
        Principal = {
          AWS = ["arn:aws:iam::${var.redhat_aws_account_id}:role/RH-Managed-OpenShift-Installer"]
        }
      },
    ]
  })

  tags = {
    rosa_role_prefix = "ManagedOpenShift"
    rosa_role_type = "OCM"
    rosa_environment = "production"
  }
}

resource "aws_iam_policy" "ocm_role_policy" {
  count = length(var.ocm_orgs) == 0 ? 0 : 1
  name        = "ManagedOpenShift-OCM-Role-Policy"
  policy = "${file("${path.module}/sts_ocm_permission_policy.json")}"

  tags = {
    rosa_role_prefix = "ManagedOpenShift"
    rosa_role_type = "OCM"
    rosa_environment = "production"
  }
    
}

resource "aws_iam_policy_attachment" "ocm_role_policy_attachment" {
  count = length(var.ocm_orgs) == 0 ? 0 : 1
  name       = "ocm-role-policy-attachment"
  roles      = aws_iam_role.ocm_role.*.name
  policy_arn = aws_iam_policy.ocm_role_policy[0].arn
}