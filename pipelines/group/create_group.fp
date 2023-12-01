pipeline "create_group" {
  title       = "Create Group"
  description = "Creates a new group with OKTA_GROUP type."

  param "api_token" {
    type        = string
    description = local.api_token_param_description
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = local.domain_param_description
    default     = var.domain
  }

  param "group_name" {
    type        = string
    description = "The name of the group."
  }

  param "group_description" {
    type        = string
    description = "The description of the group."
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
    description = "Created group."
    value       = step.http.add_group.response_body
  }
}
