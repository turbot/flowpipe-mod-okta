pipeline "delete_group" {
  title       = "Delete Group"
  description = "Deletes a group with OKTA_GROUP type."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  step "http" "delete_group" {
    method = "delete"
    url    = "${param.conn.domain}/api/v1/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }
}
