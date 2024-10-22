pipeline "unassign_user" {
  title       = "Unassign User"
  description = "Unassigns a user from a group with 'OKTA_GROUP' type."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "remove_user_from_group" {
    method = "delete"
    url    = "${param.conn.domain}/api/v1/groups/${param.group_id}/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }
}
