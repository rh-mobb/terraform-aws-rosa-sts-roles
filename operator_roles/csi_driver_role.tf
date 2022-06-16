resource "aws_iam_role" "csi_drivers_role" {
  count = length(var.clusters)
  name = "${var.clusters[count.index].operator_role_suffix}-openshift-cluster-csi-drivers-ebs-cloud-cre"
  assume_role_policy =   jsonencode(templatefile("${path.module}/assume_role.tftpl", {
      cluster_id = var.clusters[count.index].id, 
      account_id = data.aws_caller_identity.current.account_id,
      sub_string = "system:serviceaccount:openshift-cluster-csi-drivers:aws-ebs-csi-driver-operator"
      }
      )
  )

  tags = {
    rosa_cluster_id = var.clusters[count.index].id
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-cluster-csi-drivers"
    operator_name = "ebs-cloud-credentials"
  }
}

resource "aws_iam_policy_attachment" "csi_drivers_role_policy_attachment" {
  count = length(var.clusters) == 0 ? 0 : 1  
  name       = "csi-drivers-role-policy-attachment"
  roles      = aws_iam_role.csi_drivers_role.*.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ManagedOpenShift-openshift-cluster-csi-drivers-ebs-cloud-credent"
}