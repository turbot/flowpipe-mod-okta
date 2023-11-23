pipeline "deactivate_user_synchronously" {
  title       = "Deactivate User"
  description = "Deactivate a user by ID. The user is deprovisioned from all assigned applications which may destroy their data such as email or files. This action cannot be recovered."

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

  step "http" "deactivate_user_synchronously" {
    method = "post"
    //sendEmail	Sends a deactivation email to the administrator if true. Default value is false.
    url    = "${param.domain}/api/v1/users/${param.user_id}/lifecycle/deactivate?sendEmail=true"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "response" {
    description = "Response details."
    value       = step.http.deactivate_user_synchronously.response_body
  }
}
