pipeline "activate_user" {
  title       = "Activate User"
  description = "Activate a user by ID. This operation can only be performed on users with a STAGED or DEPROVISIONED status. Activation of a user is an asynchronous operation."

  param "api_token" {
    type        = string
    description = "The Okta personal access api_token to authenticate to the okta APIs."
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
  }

  param "user_id" {
    description = "The ID of an user."
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

  output "response" {
    description = "Response details."
    value       = step.http.activate_user.response_body
  }
}
