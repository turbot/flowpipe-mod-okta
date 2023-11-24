pipeline "assign_user" {
  title       = "Assign User"
  description = "Assigns a user to a group with 'OKTA_GROUP' type."

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

  param "user_id" {
    description = local.user_id_param_description
    type        = string
  }

  step "http" "assign_user" {
    method = "put"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}
