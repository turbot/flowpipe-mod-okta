pipeline "unassign_user" {
  title       = "Unassign User"
  description = "Unassigns a user from a group with 'OKTA_GROUP' type."

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

  step "http" "remove_user_from_group" {
    method = "delete"
    url    = "${param.domain}/api/v1/groups/${param.group_id}/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }
}