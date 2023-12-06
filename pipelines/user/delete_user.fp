pipeline "delete_user" {
  title       = "Delete User"
  description = "Deletes a user permanently. This operation can only be performed on users that have a DEPROVISIONED status. This action cannot be recovered!."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "delete_user" {
    method = "delete"
    url    = "${credential.okta[param.cred].domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }
}
