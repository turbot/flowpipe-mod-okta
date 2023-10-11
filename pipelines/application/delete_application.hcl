pipeline "delete_application" {
  description = "Delete Application."

  param "token" {
    type    = string
    default = var.token
  }

  param "domain" {
    type    = string
    default = var.okta_domain
  }

  param "app_id" {
    type = string
  }

  step "http" "delete_app" {
    title  = "Delete an application."
    method = "delete"
    url    = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }


  output "response_body" {
    value = step.http.delete_app.response_body
  }
  output "response_headers" {
    value = step.http.delete_app.response_headers
  }
  output "status_code" {
    value = step.http.delete_app.status_code
  }

}
