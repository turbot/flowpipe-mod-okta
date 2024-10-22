pipeline "get_group" {
  title       = "Get Group"
  description = "Retrieves a group by ID."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  step "http" "get_group" {
    method = "get"
    url    = "${param.conn.domain}/api/v1/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }

  output "group" {
    description = "Group details."
    value       = step.http.get_group.response_body
  }
}
