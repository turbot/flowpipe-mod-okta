pipeline "list_applications" {
  title       = "List Applications"
  description = "Lists all applications."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  step "http" "list_applications" {
    method = "get"
    url    = "${param.conn.domain}/api/v1/apps?limit=200"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }

    loop {
      until = length(split(",", result.response_headers["Link"])) < 2

      url = regex("<([^>]+)>; rel=\"next\"", element([for s in split(",", result.response_headers["Link"]) : s if strcontains(s, "rel=\"next\"")], 0))[0]
    }
  }

  output "applications" {
    description = "List of applications."
    value       = flatten([for entry in step.http.list_applications : entry.response_body])
  }
}
