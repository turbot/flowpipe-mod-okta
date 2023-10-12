pipeline "get_group" {
  title       = "Get Group"
  description = "Get a group by ID."

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

  param "group_id" {
    description = "The ID of a group."
    type        = string
  }

  step "http" "get_group" {
    method = "get"
    url    = "${param.domain}/api/v1/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }


  output "group" {
    description = "Group details."
    value       = step.http.get_group.response_body
  }
}
