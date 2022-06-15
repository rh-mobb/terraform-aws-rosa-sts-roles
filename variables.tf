variable redhat_aws_account_id {
    type = string
    default = "710019948333"
}

variable rosa_openshift_version {
    type = string
    default = "4.10"
}

variable create_account_roles {
    type = bool
    default = false
}