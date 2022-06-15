resource "aws_iam_policy" "openshift-cloud-network-config-controller-cloud" {
  name        = "ManagedOpenShift-openshift-cloud-network-config-controller-cloud"
  policy = "${file("${path.module}/openshift_cloud_network_config_controller_cloud_credentials_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-cloud-network-config-controller"
    operator_name = "cloud-credentials"
  }    
}

resource "aws_iam_policy" "openshift-machine-api-aws-cloud-credentials" {
  name        = "ManagedOpenShift-openshift-machine-api-aws-cloud-credentials"
  policy = "${file("${path.module}/openshift_machine_api_aws_cloud_credentials_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-machine-api"
    operator_name = "aws-cloud-credentials"
  }    
}

resource "aws_iam_policy" "openshift-cloud-credential-operator-cloud-crede" {
  name        = "ManagedOpenShift-openshift-cloud-credential-operator-cloud-crede"
  policy = "${file("${path.module}/openshift_cloud_credential_operator_cloud_credential_operator_iam_ro_creds_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-cloud-credential-operator"
    operator_name = "cloud-credential-operator-iam-ro-creds"
  }    
}

resource "aws_iam_policy" "openshift-image-registry-installer-cloud-creden" {
  name        = "ManagedOpenShift-openshift-image-registry-installer-cloud-creden"
  policy = "${file("${path.module}/openshift_image_registry_installer_cloud_credentials_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-image-registry"
    operator_name = "installer-cloud-credentials"
  }    
}

resource "aws_iam_policy" "openshift-ingress-operator-cloud-credentials" {
  name        = "ManagedOpenShift-openshift-ingress-operator-cloud-credentials"
  policy = "${file("${path.module}/openshift_ingress_operator_cloud_credentials_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-ingress-operator"
    operator_name = "cloud-credentials"
  }    
}

resource "aws_iam_policy" "openshift-cluster-csi-drivers-ebs-cloud-credent" {
  name        = "ManagedOpenShift-openshift-cluster-csi-drivers-ebs-cloud-credent"
  policy = "${file("${path.module}/openshift_cluster_csi_drivers_ebs_cloud_credentials_policy.json")}"

  tags = {
    rosa_openshift_version = var.rosa_openshift_version
    rosa_role_prefix = "ManagedOpenShift"
    operator_namespace = "openshift-cluster-csi-drivers"
    operator_name = "ebs-cloud-credentials"
  }    
}