resource "aws_iam_role" "machine_api_role" {
  count = length(var.clusters)
  name = "${var.clusters[count.index].operator_role_prefix}-openshift-machine-api-aws-cloud-credentials"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Condition = {
            StringEquals = {
                "rh-oidc.s3.us-east-1.amazonaws.com/${var.clusters[count.index].id}:sub" = ["system:serviceaccount:openshift-machine-api:machine-api-controllers"]
            }
        }
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/rh-oidc.s3.us-east-1.amazonaws.com/${var.clusters[count.index].id}"
        }
      },
    ]
  })

  tags = {
    rosa_cluster_id = var.clusters[count.index].id
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-machine-api"
    operator_name = "aws-cloud-credentials"
  }
}

resource "aws_iam_role_policy_attachment" "machine_api_role_policy_attachment" {
  count = length(var.clusters)
  role = aws_iam_role.machine_api_role[count.index].name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ManagedOpenShift-openshift-machine-api-aws-cloud-credentials"
}