resource "aws_iam_role" "support_role" {
  name = "ManagedOpenShift-Support-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.redhat_aws_account_id}:role/RH-Technical-Support-Access"
        }
      },
    ]
  })

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    rosa_role_type = "support"
  }
}

resource "aws_iam_policy" "support_role_policy" {
  name        = "ManagedOpenShift-Support-Role-Policy"
  policy = "${file("${path.module}/sts_support_permission_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    rosa_role_type = "support"
  }
    
}

resource "aws_iam_policy_attachment" "support_role_policy_attachment" {
  name       = "support-role-policy-attachment"
  roles      = [aws_iam_role.support_role.name]
  policy_arn = aws_iam_policy.support_role_policy.arn
}
