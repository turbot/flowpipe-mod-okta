locals {
  user_common_param = {
    email        = "email"
    first_name   = "firstName"
    last_name    = "lastName"
    login        = "login"
    mobile_phone = "mobilePhone"
  }

  application_common_param = {
    label        = "label"
    name         = "name"
    sign_on_mode = "signOnMode"
    status       = "status"
  }
}

# Common descriptions
locals {
  cred_param_description           = "Name for credentials to use. If not provided, the default credentials will be used."
  application_id_param_description = "Application ID."
  group_id_param_description       = "The ID of the group."
  user_id_param_description        = "The unique key for the user."
}
