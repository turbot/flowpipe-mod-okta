pipeline "add_group" {
  title       = "Create Group"
  description = "Create a group."

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

  param "group_name" {
    type = string
  }

  param "group_description" {
    type = string
  }

  step "http" "add_group" {
    method = "post"
    url    = "${param.domain}/api/v1/groups"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }

    request_body = jsonencode({
      profile = {
        name        = param.group_name
        description = param.group_description
      }
    })
  }

  output "group" {
    description = "Group details."
    value       = step.http.add_group.response_body
  }
}
