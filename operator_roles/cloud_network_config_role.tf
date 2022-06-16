resource "aws_iam_role" "cloud_network_config_role" {
  count = length(var.clusters)
  name = "${var.clusters[count.index].operator_role_suffix}-openshift-cloud-network-config-controller-c"
  assume_role_policy =   jsonencode(templatefile("${path.module}/assume_role.tftpl", {
      cluster_id = var.clusters[count.index].id, 
      account_id = data.aws_caller_identity.current.account_id,
      sub_string = "system:serviceaccount:openshift-cloud-network-config-controller:cloud-network-config-controller"
      }
      )
  )

  tags = {
    rosa_cluster_id = var.clusters[count.index].id
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-cloud-network-config-controller"
    operator_name = "cloud-credentials"
  }
}

resource "aws_iam_policy_attachment" "cloud_network_config_role_policy_attachment" {
  count = length(var.clusters) == 0 ? 0 : 1  
  name       = "cloud-network-config-role-policy-attachment"
  roles      = aws_iam_role.cloud_network_config_role.*.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ManagedOpenShift-openshift-cloud-network-config-controller-cloud"
}