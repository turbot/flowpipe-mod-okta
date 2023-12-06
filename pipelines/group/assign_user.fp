pipeline "assign_user" {
  title       = "Assign User"
  description = "Assigns a user to a group with 'OKTA_GROUP' type."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "assign_user" {
    method = "put"
    url    = "${credential.okta[param.cred].domain}/api/v1/groups/${param.group_id}/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }
}
