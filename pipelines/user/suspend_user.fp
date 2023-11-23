pipeline "suspend_user" {
  title       = "Suspend User"
  description = "Suspend a user by ID. This operation can only be performed on users with an ACTIVE status. The user has a status of SUSPENDED when the process is complete. Suspended users can't log in to Okta. Their group and app assignments are retained. They can only be unsuspended or deactivated."

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

  step "http" "suspend_user" {
    method = "post"
    url    = "${param.domain}/api/v1/users/${param.user_id}/lifecycle/suspend"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
