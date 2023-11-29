pipeline "unassign_user" {
  title       = "Unassign User"
  description = "Unassigns a user from a group with 'OKTA_GROUP' type."

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

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "remove_user_from_group" {
    method = "delete"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}