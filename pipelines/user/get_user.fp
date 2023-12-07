pipeline "get_user" {
  title       = "Retrieve User"
  description = "Retrieves a user from your Okta organization."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "get_user" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "user" {
    description = "User details."
    value       = step.http.get_user.response_body
  }
}
