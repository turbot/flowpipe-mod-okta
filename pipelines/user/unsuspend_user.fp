pipeline "unsuspend_user" {
  title       = "Unsuspend User"
  description = "Unsuspends a user and returns them to the ACTIVE state. This operation can only be performed on users that have a SUSPENDED status."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "unsuspend_user" {
    method = "post"
    url    = "${credential.okta[param.cred].domain}/api/v1/users/${param.user_id}/lifecycle/unsuspend"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }
}
