resource "aws_iam_role" "controlplane_role" {
  name = "ManagedOpenShift-ControlPlane-Role"
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
    rosa_role_type = "instance_controlplane"
  }

}

resource "aws_iam_policy" "controlplane_role_policy" {
  name        = "ManagedOpenShift-ControlPlane-Role-Policy"
  policy = "${file("${path.module}/sts_instance_controlplane_permission_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    rosa_role_type = "instance_controlplane"
  }  
}

resource "aws_iam_policy_attachment" "controlplane_role_policy_attachment" {
  name       = "controlplane-role-policy-attachment"
  roles      = [aws_iam_role.controlplane_role.name]
  policy_arn = aws_iam_policy.controlplane_role_policy.arn
}
