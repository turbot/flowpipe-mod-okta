pipeline "unsuspend_user" {
  title       = "Unsuspend User"
  description = "Unsuspends a user and returns them to the ACTIVE state. This operation can only be performed on users that have a SUSPENDED status."

  param "api_token" {
    description = local.api_token_param_description
    type        = string
    default     = var.api_token
  }

  param "domain" {
    description = local.domain_param_description
    type        = string
    default     = var.domain
  }

  param "user_id" {
    description = local.user_id_param_description
    type        = string
  }

  step "http" "unsuspend_user" {
    method = "post"
    url    = "${param.domain}/api/v1/users/${param.user_id}/lifecycle/unsuspend"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
