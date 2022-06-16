resource "aws_iam_role" "cloud-credential_role" {
  count = length(var.clusters)
  name = "${var.clusters[count.index].operator_role_suffix}-openshift-machine-api-aws-cloud-credentials"
  assume_role_policy = jsonencode(templatefile("${path.module}/assume_role.tftpl", {
      cluster_id = var.clusters[count.index].id, 
      account_id = data.aws_caller_identity.current.account_id,
      sub_string = "system:serviceaccount:openshift-cloud-credential-operator:cloud-credential-operato"
      }
      )
  )

  tags = {
    rosa_cluster_id = var.clusters[count.index].id
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-cloud-credential-operator"
    operator_name = "cloud-credential-operator-iam-ro-creds"
  }
}

resource "aws_iam_policy_attachment" "cloud-credential_role_policy_attachment" {
  count = length(var.clusters) == 0 ? 0 : 1  
  name       = "cloud-credential-role-policy-attachment"
  roles      = aws_iam_role.cloud-credential_role.*.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ManagedOpenShift-openshift-cloud-credential-operator-cloud-crede"
}