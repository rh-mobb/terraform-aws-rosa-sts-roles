output ocm_user_role_arns {
    description = "ocm user roles' arns"
    value = aws_iam_role.user_role.*.arn
}