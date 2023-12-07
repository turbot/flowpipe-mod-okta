pipeline "unassign_group" {
  title       = "Unassign Group"
  description = "Unassigns a group from an application."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  step "http" "unassign_group" {
    method = "delete"
    url    = "${credential.okta[param.cred].domain}/api/v1/apps/${param.app_id}/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }
}
