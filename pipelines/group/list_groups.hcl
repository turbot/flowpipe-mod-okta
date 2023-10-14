pipeline "list_groups" {
  title       = "List Groups"
  description = "List of groups for the okta account."

  param "api_token" {
    type        = string
    description = "The Okta personal access api_token to authenticate to the okta APIs."
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
  }

  step "http" "list_groups" {
    method = "get"
    url    = "${param.domain}/api/v1/groups?limit=200"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }


  output "groups" {
    description = "Group details."
    value       = step.http.list_groups.response_body
  }
}
