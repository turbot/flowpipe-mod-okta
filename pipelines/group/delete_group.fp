pipeline "delete_group" {
  title       = "Delete Group"
  description = "Deletes a group with OKTA_GROUP type."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  step "http" "delete_group" {
    method = "delete"
    url    = "${credential.okta[param.cred].domain}/api/v1/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }
}
