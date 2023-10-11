pipeline "update_application" {
  description = "Update Application."

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

  param "name" {
    type = string
    default = ""
  }

  param "label" {
    type = string
    default = ""
  }

  param "sign_on_mode" {
    type = string
    default = ""
  }

  param "status" {
    type = string
    default = ""
  }

  step "pipeline" "get_app_details" {
    pipeline = pipeline.get_application
    args = {
        app_id=param.app_id
    }
  }

  step "http" "update_app" {
    depends_on = [ step.pipeline.get_app_details ]
    title  = "Updated an application."
    method = "put"
    url    = "${param.domain}/api/v1/apps/${param.app_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }

    request_body = jsonencode({
      name = (param.name != "" ? param.label : jsondecode(step.pipeline.get_app_details.response_body)["label"])
      label = (param.label != "" ? param.label : jsondecode(step.pipeline.get_app_details.response_body)["label"])
      signOnMode = (param.sign_on_mode != "" ? param.sign_on_mode : jsondecode(step.pipeline.get_app_details.response_body)["signOnMode"])
      status = (param.status != "" ? param.status : jsondecode(step.pipeline.get_app_details.response_body)["status"])

    })
  }

  output "response_body" {
    value = step.http.update_app.response_body
  }
  output "request_body" {
    value = step.http.update_app
  }
  output "response_headers" {
    value = step.http.update_app.response_headers
  }
  output "status_code" {
    value = step.http.update_app.status_code
  }
}