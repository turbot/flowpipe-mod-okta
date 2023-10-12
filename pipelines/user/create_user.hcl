pipeline "create_user" {
  title       = "Create User"
  description = "Create a user."

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

  // Common param for creating an user
  param "first_name" {
    type        = string
    description = "The first name of the user."
    default     = ""
  }

  param "last_name" {
    type        = string
    description = "The last name of the user."
    default     = ""
  }

  param "email" {
    type        = string
    description = "The email address associated with the user's account."
    default     = ""
  }

  param "login" {
    type        = string
    description = "The username or identifier used for the user to log in."
    default     = ""
  }

  param "mobile_phone" {
    type        = string
    description = "The user's mobile phone number."
    default     = ""
  }

  param "credential_question" {
    type        = string
    description = "security question that the user can set up for account recovery. "
    default     = ""
  }
  param "credential_ans" {
    type        = string
    description = "The user's answer to the security question."
    default     = ""
  }
  param "credential_pwd" {
    type    = string
    default = "The user's password for authentication."
  }

  // Param for hash password
  // Will be uncomment when those will be used in steps.

  // param "hash_algorithm" {
  //   type    = string
  //   default = ""
  // }
  // param "hash_work_factor" {
  //   type    = number
  //   default = 0
  // }
  // param "hash_salt" {
  //   type    = string
  //   default = ""
  // }
  // param "hash_value" {
  //   type    = string
  //   default = ""
  // }


  // Create user with password
  step "http" "create_user_with_password" {
    if     = param.credential_pwd != ""
    method = "post"
    url    = "${param.domain}/api/v1/users"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.token}"
    }

    request_body = jsonencode({
      profile = {
        firstName = param.first_name
        lastName  = param.last_name
        email     = param.email
        login     = param.login
      }
      credentials = {
        password = param.credential_pwd
      }
    })
  }

  // Note: Currently, the feature of assigning multiple step outputs to a single variable is not available, so I'm commenting out the following code temporarily. Also, please note that the two steps below can belong to two separate pipelines, based on different input parameters for user creation.

  // Create user without password
  // step "http" "create_user_with_recovery_question" {
  //   if     = (param.credential_pwd == "" && param.credential_question != "" && param.credential_ans != "")
  //   title  = "Add an Okta user."
  //   method = "post"
  //   url    = "${param.domain}/api/v1/users"
  //   request_headers = {
  //     Content-Type  = "application/json"
  //     Authorization = "SSWS ${param.token}"
  //   }

  //   request_body = jsonencode({
  //     profile = {
  //       firstName = param.profile.firstName
  //       lastName  = param.profile.lastName
  //       email     = param.profile.email
  //       login     = param.profile.login
  //     }
  //     credentials = {
  //       recovery_question = {
  //         question = param.credential_question
  //         answer   = param.credential_ans
  //       }
  //     }
  //   })
  // }

  // Create User with imported hashed password
  // step "http" "create_user_with_imported_hash_pwd" {
  //   if     = ( param.credential_pwd == "" && param.hash_algorithm != "" && param.hash_work_factor != 0 && param.hash_salt != "" && param.hash_value != "")
  //   title  = "Add an Okta user."
  //   method = "post"
  //   url    = "${param.domain}/api/v1/users"
  //   request_headers = {
  //     Content-Type  = "application/json"
  //     Authorization = "SSWS ${param.token}"
  //   }

  //   request_body = jsonencode({
  //     profile = {
  //       firstName = param.profile.firstName
  //       lastName  = param.profile.lastName
  //       email     = param.profile.email
  //       login     = param.profile.login
  //     }
  //     credentials = {
  //       parrword = {
  //         hash = {
  //           algorithm = param.hash_algorithm
  //           workFactor = param.hash_work_factor
  //           salt = param.hash_salt
  //           value = param.hash_value
  //         }
  //       }
  //     }
  //   })
  // }

  output "user" {
    description = "User details."
    value       = step.http.create_user_with_password.response_body
  }
}
