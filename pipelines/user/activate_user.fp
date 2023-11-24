pipeline "activate_user" {
  title       = "Activate User"
  description = "Activate a user. This operation can only be performed on users with a STAGED or DEPROVISIONED status. Activation of a user is an asynchronous operation."

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

  step "http" "activate_user" {
    method = "post"
    url    = "${param.domain}/api/v1/users/${param.user_id}/lifecycle/activate"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "activation_details" {
    value       = step.http.activate_user.response_body
    description = "Activation details."
  }
}
