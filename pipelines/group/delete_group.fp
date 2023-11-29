pipeline "delete_group" {
  title       = "Delete Group"
  description = "Deletes a group with OKTA_GROUP type."

  param "api_token" {
    type        = string
    description = local.api_token_param_description
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = local.domain_param_description
    default     = var.domain
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  step "http" "delete_group" {
    method = "delete"
    url    = "${param.domain}/api/v1/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
