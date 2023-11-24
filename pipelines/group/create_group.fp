pipeline "create_group" {
  title       = "Create Group"
  description = "Creates a new group with OKTA_GROUP type."

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

  param "group_name" {
    description = "The name of the group."
    type        = string
  }

  param "group_description" {
    description = "The description of the group."
    type        = string
  }

  step "http" "add_group" {
    method = "post"
    url    = "${param.domain}/api/v1/groups"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }

    request_body = jsonencode({
      profile = {
        name        = param.group_name
        description = param.group_description
      }
    })
  }

  output "group" {
    value       = step.http.add_group.response_body
    description = "Created group."
  }
}
