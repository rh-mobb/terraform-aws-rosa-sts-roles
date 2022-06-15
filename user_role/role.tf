resource "aws_iam_role" "user_role" {
  count = length(var.ocm_users)
  name = "ManagedOpenShift-User-${var.ocm_users[count.index].user_name}-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Condition = {
            StringEquals = {                
                "sts:ExternalId" = var.ocm_users[count.index].id
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
    rosa_role_type = "User"
    rosa_environment = "production"
  }
}