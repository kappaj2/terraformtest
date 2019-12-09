
provider "aws"{
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}


# aws_cognito_user_pool.mypool:
resource "aws_cognito_user_pool" "ClairAdminUsersPool" {

    auto_verified_attributes = [
        "email",
    ]
    mfa_configuration        = "OFF"
    name                     = "ClairAdminUsersPool"
    tags                     = {}

    admin_create_user_config {
        allow_admin_create_user_only = false
        unused_account_validity_days = 7
    }

    email_configuration {
        email_sending_account = "COGNITO_DEFAULT"
    }

    password_policy {
        minimum_length    = 8
        require_lowercase = true
        require_numbers   = true
        require_symbols   = false
        require_uppercase = true
    }

    schema {
        attribute_data_type      = "String"
        developer_only_attribute = false
        mutable                  = true
        name                     = "email"
        required                 = true

        string_attribute_constraints {
            max_length = "2048"
            min_length = "0"
        }
    }

    verification_message_template {
        default_email_option = "CONFIRM_WITH_CODE"
    }
}


resource "aws_cognito_user_group" "AGENT_APP" {
  name         = "AGENT_APP"
  user_pool_id = aws_cognito_user_pool.ClairAdminUsersPool.id
  description  = "AGENT_APP Role"
}
resource "aws_cognito_user_group" "SELPAL_APP" {
  name         = "SELPAL_APP"
  user_pool_id = aws_cognito_user_pool.ClairAdminUsersPool.id
  description  = "SELPAL_APP Role"
}
resource "aws_cognito_user_group" "STEWARD_BANK" {
  name         = "STEWARD_BANK"
  user_pool_id = aws_cognito_user_pool.ClairAdminUsersPool.id
  description  = "STEWARD_BANK Role"
}
resource "aws_cognito_user_group" "PEP" {
  name         = "PEP"
  user_pool_id = aws_cognito_user_pool.ClairAdminUsersPool.id
  description  = "PEP Role"
}
resource "aws_cognito_user_group" "ELECTRUM" {
  name         = "ELECTRUM"
  user_pool_id = aws_cognito_user_pool.ClairAdminUsersPool.id
  description  = "ELECTRUM Role"
}
resource "aws_cognito_user_group" "MAMA" {
  name         = "MAMA"
  user_pool_id = aws_cognito_user_pool.ClairAdminUsersPool.id
  description  = "MAMA Role"
}
resource "aws_cognito_user_group" "BACKEND" {
  name         = "BACKEND"
  user_pool_id = aws_cognito_user_pool.ClairAdminUsersPool.id
  description  = "BACKEND Role"
}
resource "aws_cognito_user_group" "MAMA_PNP" {
  name         = "MAMA_PNP"
  user_pool_id = aws_cognito_user_pool.ClairAdminUsersPool.id
  description  = "MAMA_PNP Role"
}







resource "aws_cognito_user_pool" "ClairBackendClientsPool" {

    auto_verified_attributes = [
        "email",
    ]
    mfa_configuration        = "OFF"
    name                     = "ClairBackendClientsPool"
    tags                     = {}

    admin_create_user_config {
        allow_admin_create_user_only = false
        unused_account_validity_days = 7
    }

    email_configuration {
        email_sending_account = "COGNITO_DEFAULT"
    }

    password_policy {
        minimum_length    = 8
        require_lowercase = true
        require_numbers   = true
        require_symbols   = false
        require_uppercase = true
    }

    schema {
        attribute_data_type      = "String"
        developer_only_attribute = false
        mutable                  = true
        name                     = "email"
        required                 = true

        string_attribute_constraints {
            max_length = "2048"
            min_length = "0"
        }
    }

    verification_message_template {
        default_email_option = "CONFIRM_WITH_CODE"
    }
}


resource "aws_cognito_user_pool_client" "ELECTRUM_PRINCIPAL" {
  name = "ELECTRUM_PRINCIPAL"
  user_pool_id = aws_cognito_user_pool.ClairBackendClientsPool.id
  generate_secret = true
  refresh_token_validity = 3650
  # allowed_custom_scopes = ["scope1", "scope2"]
  allowed_oauth_flows = ["client_credentials"]
}


resource "aws_cognito_resource_server" "ResourceServer1" {
  identifier = "ROLES"
  name       = "ROLES"

  scope {
    scope_name        = "sample-scope"
    scope_description = "a Sample Scope Description"

  }

  user_pool_id = aws_cognito_user_pool.ClairBackendClientsPool.id
}

#allowed_oauth_scopes = ["${aws_cognito_resource_server.resource_server.scope_identifiers }"]
