pipeline "remove_group_from_application" {
  title       = "Group removal from Application"
  description = "Remove a group assignment from an application."

  param "token" {
    type        = string
    description = "The Okta personal access token to authenticate to the okta APIs."
    default     = var.token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
  }

  param "group_id" {
    description = "The ID of a group."
    type        = string
  }

  param "app_id" {
    description = "ID of an application."
    type        = string
  }

  step "http" "remove_group_from_application" {
    method = "delete"
    url    = "${param.domain}/api/v1/apps/${param.app_id}/groups/${param.group_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }
  }
}