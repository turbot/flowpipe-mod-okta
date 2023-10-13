pipeline "list_group" {
  title       = "List Groups"
  description = "List of groups for the okta account."

  param "token" {
    type        = string
    description = "The Okta personal access token to authenticate to the okta APIs."
    default     = var.token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
  }

  step "http" "list_group" {
    method = "get"
    url    = "${param.domain}/api/v1/groups?limit=200"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }


  output "group" {
    description = "Group details."
    value       = step.http.list_group.response_body
  }
}