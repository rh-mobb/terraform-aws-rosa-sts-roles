resource "aws_iam_role" "image_registry_role" {
  count = length(var.clusters)
  name = "${var.clusters[count.index].operator_role_suffix}-openshift-image-registry-installer-cloud-cr"
  assume_role_policy =   jsonencode(templatefile("${path.module}/assume_role.tftpl", {
      cluster_id = var.clusters[count.index].id, 
      account_id = data.aws_caller_identity.current.account_id,
      sub_string = "system:serviceaccount:openshift-image-registry:cluster-image-registry-operator"
      }
      )
  )

  tags = {
    rosa_cluster_id = var.clusters[count.index].id
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-image-registry"
    operator_name = "installer-cloud-credentials"
  }
}

resource "aws_iam_policy_attachment" "image_registry_role_policy_attachment" {
  count = length(var.clusters) == 0 ? 0 : 1  
  name       = "image-registry-role-policy-attachment"
  roles      = aws_iam_role.image_registry_role.*.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ManagedOpenShift-openshift-image-registry-installer-cloud-creden"
}