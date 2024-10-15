pipeline "unsuspend_user" {
  title       = "Unsuspend User"
  description = "Unsuspends a user and returns them to the ACTIVE state. This operation can only be performed on users that have a SUSPENDED status."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "unsuspend_user" {
    method = "post"
    url    = "${param.conn.domain}/api/v1/users/${param.user_id}/lifecycle/unsuspend"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }
}
