resource "aws_iam_role" "worker_role" {
  name = "ManagedOpenShift-Worker-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ec2.amazonaws.com"]
        }
      },
    ]
  })

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    rosa_role_type = "instance_worker"
  }
}

resource "aws_iam_policy" "worker_role_policy" {
  name        = "ManagedOpenShift-Worker-Role-Policy"
  policy = "${file("${path.module}/sts_instance_worker_permission_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    rosa_role_type = "instance_worker"
  }
    
}

resource "aws_iam_policy_attachment" "worker_role_policy_attachment" {
  name       = "worker-role-policy-attachment"
  roles      = [aws_iam_role.worker_role.name]
  policy_arn = aws_iam_policy.worker_role_policy.arn
}
