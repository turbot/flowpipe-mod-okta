pipeline "activate_user" {
  title       = "Activate User"
  description = "Activate a user. This operation can only be performed on users with a STAGED or DEPROVISIONED status. Activation of a user is an asynchronous operation."

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

  step "http" "activate_user" {
    method = "post"
    url    = "${param.domain}/api/v1/users/${param.user_id}/lifecycle/activate"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "activation_details" {
    description = "Activation details."
    value       = step.http.activate_user.response_body
  }
}
