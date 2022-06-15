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

variable ocm_orgs {
    description = "ocm orgs"
    type = list(object({
        org_id = string
        external_id = string
    }))
    default = []
}

variable ocm_users {
    description = "ocm users account id and username"
    type = list(object({
        id = string
        user_name = string
    }))
    default = []
}

