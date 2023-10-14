pipeline "delete_user" {
  title       = "Delete User"
  description = "Delete a user by ID."

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

  step "http" "delete_user" {
    method = "delete"
    url    = "${param.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
