pipeline "list_assigned_groups" {
  title       = "List Assigned Groups"
  description = "Lists all group assignments for an application."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "app_id" {
    type        = string
    description = local.application_id_param_description
  }

  step "http" "list_assigned_groups" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/apps/${param.app_id}/groups?limit=200"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }

    loop {
      until = length(split(",", result.response_headers["Link"])) < 2

      url = regex("<([^>]+)>; rel=\"next\"", element([for s in split(",", result.response_headers["Link"]) : s if strcontains(s, "rel=\"next\"")], 0))[0]
    }
  }

  output "application_groups" {
    description = "List of assigned groups for the application."
    value       = flatten([for entry in step.http.list_assigned_groups : entry.response_body])
  }
}
