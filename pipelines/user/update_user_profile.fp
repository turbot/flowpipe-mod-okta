pipeline "update_user_profile" {
  title       = "Update User Profile"
  description = "Update a user profile by ID."

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

  param "user_id" {
    description = "The ID of an user."
    type        = string
  }

  param "first_name" {
    type        = string
    description = "The first name of the user."
    optional    = true
  }

  param "last_name" {
    type        = string
    description = "The last name of the user."
    optional    = true
  }

  param "email" {
    type        = string
    description = "The email address associated with the user's account."
    optional    = true
  }

  param "login" {
    type        = string
    description = "The username or identifier used for the user to log in."
    optional    = true
  }

  param "mobile_phone" {
    type        = string
    description = "The user's mobile phone number."
    optional    = true
  }

  step "http" "update_user_profile" {
    method = "post"
    url    = "${param.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }

    request_body = jsonencode({
      profile = {
        for name, value in param : try(local.user_common_param[name], name) => value if contains(keys(local.user_common_param), name) && value != null
      }
    })
  }

  output "userProfile" {
    description = "Updated user profile details."
    value       = step.http.update_user_profile.response_body
  }
}
