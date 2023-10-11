pipeline "list_application" {
  description = "List of application of for the account."

  param "token" {
    type    = string
    default = var.token
  }

  param "domain" {
    type    = string
    default = var.okta_domain
  }

  // Kept here for future paging use
  param "app_limit" {
    type    = number
    default = 200
  }

  step "http" "list_app" {
    title  = "List of applications for an okta account."
    method = "get"
    url    = "${param.domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }


  output "response_body" {
    value = step.http.list_app.response_body
  }
  output "response_headers" {
    value = step.http.list_app.response_headers
  }
  output "status_code" {
    value = step.http.list_app.status_code
  }

}
