pipeline "update_user_profile" {
  title       = "Update User Profile"
  description = "Update a user profile by ID."

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

  step "pipeline" "get_user_details" {
    pipeline = pipeline.get_user
    args = {
      user_id = param.user_id
    }
  }

  step "http" "update_user_profile" {
    depends_on = [step.pipeline.get_user_details]
    method     = "post"
    url        = "${param.domain}/api/v1/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }

    request_body = jsonencode({
      profile = {
        firstName = (param.first_name != null ? param.first_name : jsondecode(step.pipeline.get_user_details.response_body).profile.firstName)
        lastName  = (param.last_name != null ? param.last_name : jsondecode(step.pipeline.get_user_details.response_body).profile.lastName)
        email     = (param.email != null ? param.email : jsondecode(step.pipeline.get_user_details.response_body).profile.email)
        login     = (param.login != null ? param.login : jsondecode(step.pipeline.get_user_details.response_body).profile.login)
      }
    })
  }

  output "userProfile" {
    description = "Updated user profile details."
    value       = step.http.update_user_profile.response_body
  }

  output "user" {
    description = "User details."
    value       = step.pipeline.get_user_details.response_body
  }

}
