pipeline "delete_application" {
  title       = "Delete Application"
  description = "Deletes an inactive application."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  step "http" "delete_application" {
    method = "delete"
    url    = "${param.conn.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }
}
