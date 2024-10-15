pipeline "activate_user" {
  title       = "Activate User"
  description = "Activate a user. This operation can only be performed on users with a STAGED or DEPROVISIONED status. Activation of a user is an asynchronous operation."

  tags = {
    type = "featured"
  }

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "activate_user" {
    method = "post"
    url    = "${param.conn.domain}/api/v1/users/${param.user_id}/lifecycle/activate"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }

  output "activation_details" {
    description = "Activation details."
    value       = step.http.activate_user.response_body
  }
}
