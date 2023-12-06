pipeline "get_group" {
  title       = "Retrieve Group"
  description = "Retrieves a group by ID."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  step "http" "get_group" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "group" {
    description = "Group details."
    value       = step.http.get_group.response_body
  }
}
