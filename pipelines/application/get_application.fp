pipeline "get_application" {
  title       = "Get Application"
  description = "Retrieves an application from your Okta organization by id."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  step "http" "get_application" {
    method = "get"
    url    = "${param.conn.domain}/api/v1/apps/${param.app_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }
  }

  output "application" {
    description = "Application details."
    value       = step.http.get_application.response_body
  }
}
