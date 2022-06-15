variable redhat_aws_account_id {
    type = string
    default = "710019948333"
}

variable ocm_users {
    description = "ocm users account id and username"
    type = list(object({
        id = string
        user_name = string
    }))
    default = []
}

