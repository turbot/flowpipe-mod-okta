pipeline "deactivate_user" {
  title       = "Deactivate User"
  description = "Deactivates a user. This operation can only be performed on users that do not have a DEPROVISIONED status."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  param "send_email" {
    type        = bool
    description = "Send an email notifying the user that their account has been deactivated."
    default     = false
  }

  step "http" "deactivate_user" {
    method = "post"
    url    = "${param.conn.domain}/api/v1/users/${param.user_id}/lifecycle/deactivate?sendEmail=${param.send_email}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }
}
