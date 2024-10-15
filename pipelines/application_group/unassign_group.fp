pipeline "unassign_group" {
  title       = "Unassign Group"
  description = "Unassigns a group from an application."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  step "http" "unassign_group" {
    method = "delete"
    url    = "${param.conn.domain}/api/v1/apps/${param.app_id}/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }
}
