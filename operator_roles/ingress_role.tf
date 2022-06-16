resource "aws_iam_role" "ingress_operator_role" {
  count = length(var.clusters)
  name = "${var.clusters[count.index].operator_role_suffix}-openshift-ingress-operator-cloud-credential"
  assume_role_policy =   jsonencode(templatefile("${path.module}/assume_role.tftpl", {
      cluster_id = var.clusters[count.index].id, 
      account_id = data.aws_caller_identity.current.account_id,
      sub_string = "system:serviceaccount:openshift-ingress-operator:ingress-operator"
      }
      )
  )

  tags = {
    rosa_cluster_id = var.clusters[count.index].id
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-ingress-operator"
    operator_name = "cloud-credentials"
  }
}

resource "aws_iam_policy_attachment" "ingress_operator_role_policy_attachment" {
  count = length(var.clusters) == 0 ? 0 : 1  
  name       = "ingress-operator-role-policy-attachment"
  roles      = aws_iam_role.ingress_operator_role.*.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ManagedOpenShift-openshift-ingress-operator-cloud-credentials"
}