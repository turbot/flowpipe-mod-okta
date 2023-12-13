pipeline "create_group" {
  title       = "Create Group"
  description = "Creates a new group with OKTA_GROUP type."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
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
    url    = "${credential.okta[param.cred].domain}/api/v1/groups"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
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
