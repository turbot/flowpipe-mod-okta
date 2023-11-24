pipeline "delete_user" {
  title       = "Delete User"
  description = "Deletes a user permanently. This operation can only be performed on users that have a DEPROVISIONED status. This action cannot be recovered!."

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

  step "http" "delete_user" {
    method = "delete"
    url    = "${param.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
