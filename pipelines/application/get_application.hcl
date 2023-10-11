pipeline "get_application" {
  description = "Get an application details."

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

  step "http" "get_app" {
    title  = "Get an application details."
    method = "get"
    url    = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }


  output "response_body" {
    value = step.http.get_app.response_body
  }
  output "response_headers" {
    value = step.http.get_app.response_headers
  }
  output "status_code" {
    value = step.http.get_app.status_code
  }

}
