resource "aws_iam_role" "machine_api_role" {
  count = length(var.clusters)
  name = "${var.clusters[count.index].operator_role_suffix}-openshift-machine-api-aws-cloud-credentials"
  assume_role_policy =   jsonencode(templatefile("${path.module}/assume_role.tftpl", {
      cluster_id = var.clusters[count.index].id, 
      account_id = data.aws_caller_identity.current.account_id,
      sub_string = "system:serviceaccount:openshift-machine-api:machine-api-controllers"        
      }
      )
  )

  tags = {
    rosa_cluster_id = var.clusters[count.index].id
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-machine-api"
    operator_name = "aws-cloud-credentials"
  }
}

resource "aws_iam_policy_attachment" "machine_api_role_policy_attachment" {
  count = length(var.clusters) == 0 ? 0 : 1  
  name       = "machine-api-role-policy-attachment"
  roles      = aws_iam_role.machine_api_role.*.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ManagedOpenShift-openshift-machine-api-aws-cloud-credentials"
}