pipeline "create_group" {
  title       = "Create Group"
  description = "Creates a new group with OKTA_GROUP type."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
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
    url    = "${param.conn.domain}/api/v1/groups"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
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
