pipeline "list_deactivated_users" {
  title       = "List Deactivated Users"
  description = "List deactivated users."

  param "api_token" {
    type        = string
    description = "The Okta personal access api_token to authenticate to the okta APIs."
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
  }
  // Example filters - filter=status+eq+%22DEPROVISIONED%22+or+status+eq+%22RECOVERY%22, here used only DEPROVISIONED
  step "http" "list_deactivated_users" {
    method = "get"
    url    = "${param.domain}/api/v1/users?limit=200&filter=status+eq+%22DEPROVISIONED%22"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "users" {
    description = "Details of the dectivated users."
    value       = step.http.list_deactivated_users.response_body
  }

}
