pipeline "suspend_user" {
  title       = "Suspend User"
  description = "Suspends a user. This operation can only be performed on users with an ACTIVE status."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "suspend_user" {
    method = "post"
    url    = "${credential.okta[param.cred].domain}/api/v1/users/${param.user_id}/lifecycle/suspend"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }
}
