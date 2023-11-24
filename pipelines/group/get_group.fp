pipeline "get_group" {
  title       = "Retrieve Group"
  description = "Retrieves a group by ID."

  param "api_token" {
    description = local.api_token_param_description
    type        = string
    default     = var.api_token
  }

  param "domain" {
    description = local.domain_param_description
    type        = string
    default     = var.domain
  }

  param "group_id" {
    description = local.group_id_param_description
    type        = string
  }

  step "http" "get_group" {
    method = "get"
    url    = "${param.domain}/api/v1/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "group" {
    value       = step.http.get_group.response_body
    description = "Group details."
  }
}
