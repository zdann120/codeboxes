module Tokens
  class Generate < ActiveInteraction::Base
    string :type
    string :user_token
    string :resource_token
    integer :expires_in, default: 60 * 60 * 24

    def execute
      result = {
        user_token: user_token,
        key_type: type,
        token: resource_token,
        jti: ULID.generate,
        iat: Time.now.to_i,
        exp: (Time.now).to_i + expires_in
      }

      secret = Rails.application.secrets.secret_key_base

      jwt = JWT.encode result, secret, 'HS256'

      jwt
    end
  end
end