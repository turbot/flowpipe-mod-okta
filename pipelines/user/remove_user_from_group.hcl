pipeline "remove_user_from_group" {
  title       = "User removal from Group"
  description = "Remove a user from a group."

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

  param "group_id" {
    description = "The ID of a group."
    type        = string
  }

  param "user_id" {
    description = "The ID of an user."
    type        = string
  }

  step "http" "remove_user_from_group" {
    method = "delete"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}