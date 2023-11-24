pipeline "deactivate_user" {
  title       = "Deactivate User"
  description = "Deactivates a user. This operation can only be performed on users that do not have a DEPROVISIONED status."

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

  param send_email {
    description = "Send an email notifying the user that their account has been deactivated."
    type        = bool
    default     = false
  }

  step "http" "deactivate_user" {
    method = "post"
    url    = "${param.domain}/api/v1/users/${param.user_id}/lifecycle/deactivate?sendEmail=${param.send_email}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
