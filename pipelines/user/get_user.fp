pipeline "get_user" {
  title       = "Get User"
  description = "Retrieves a user from your Okta organization."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "get_user" {
    method = "get"
    url    = "${param.conn.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }

  output "user" {
    description = "User details."
    value       = step.http.get_user.response_body
  }
}
