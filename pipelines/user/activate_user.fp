pipeline "activate_user" {
  title       = "Activate User"
  description = "Activate a user. This operation can only be performed on users with a STAGED or DEPROVISIONED status. Activation of a user is an asynchronous operation."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "activate_user" {
    method = "post"
    url    = "${credential.okta[param.cred].domain}/api/v1/users/${param.user_id}/lifecycle/activate"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "activation_details" {
    description = "Activation details."
    value       = step.http.activate_user.response_body
  }
}
