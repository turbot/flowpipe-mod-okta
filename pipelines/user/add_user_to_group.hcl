pipeline "add_user_to_group" {
  title       = "User Addition to Group"
  description = "Add user to a group."

  param "token" {
    type        = string
    description = "The Okta personal access token to authenticate to the okta APIs."
    default     = var.token
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

  step "http" "add_user_to_group" {
    method = "put"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }

  output "userAssign" {
    description = "Details of Adding a User to a Group"
    value       = step.http.add_user_to_group.response_body
  }
}