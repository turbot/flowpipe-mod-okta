pipeline "update_user" {
  title       = "Update User"
  description = "Replaces a user's profile using strict-update semantics."

  tags = {
    recommended = "true"
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

  param "first_name" {
    type        = string
    description = "Given name of the user."
  }

  param "last_name" {
    type        = string
    description = "The family name of the user."
  }

  param "email" {
    type        = string
    description = "The primary email address of the user."
  }

  param "login" {
    type        = string
    description = "The unique identifier for the user."
  }

  step "http" "update_user" {
    method = "post"
    url    = "${param.conn.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }

    request_body = jsonencode({
      profile = {
        for name, value in param : try(local.user_common_param[name], name) => value if contains(keys(local.user_common_param), name) && value != null
      }
    })
  }

  output "user" {
    description = "Updated user details."
    value       = step.http.update_user.response_body
  }
}
