variable redhat_aws_account_id {
    type = string
    default = "710019948333"
}

variable ocm_orgs {
    description = "ocm orgs"
    type = list(object({
        org_id = string
        external_id = string
    }))
    default = []
}