pipeline "suspend_user" {
  title       = "Suspend User"
  description = "Suspends a user. This operation can only be performed on users with an ACTIVE status."

  param "api_token" {
    type        = string
    description = local.api_token_param_description
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = local.domain_param_description
    default     = var.domain
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "suspend_user" {
    method = "post"
    url    = "${param.domain}/api/v1/users/${param.user_id}/lifecycle/suspend"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
