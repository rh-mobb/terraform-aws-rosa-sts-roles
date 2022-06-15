output ocm_role_arns {
    description = "ocm roles' arns"
    value = aws_iam_role.ocm_role.*.arn
}