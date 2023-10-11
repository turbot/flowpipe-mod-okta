pipeline "add_application" {
  description = "Add Application."

  param "token" {
    type    = string
    default = var.token
  }

  param "domain" {
    type    = string
    default = var.okta_domain
  }

  param "name" {
    type = string
  }

  param "label" {
    type = string
  }

  param "sign_on_mode" {
    type = string
  }

  step "http" "add_app" {
    title  = "Add an application."
    method = "post"
    url    = "${param.domain}/api/v1/apps"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }

    request_body = jsonencode({
      name = "${param.name}"
      label = "${param.label}"
      signOnMode = "${param.sign_on_mode}"
    })
  }


  output "response_body" {
    value = step.http.add_app.response_body
  }
  output "response_headers" {
    value = step.http.add_app.response_headers
  }
  output "status_code" {
    value = step.http.add_app.status_code
  }

}
