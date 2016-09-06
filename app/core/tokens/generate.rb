module Tokens
  class Generate < ActiveInteraction::Base
    string :type
    string :user_token
    string :resource_token

    def execute
      result = {
        user_token: user_token,
        key_type: type,
        token: resource_token,
        jti: ULID.generate,
        iat: Time.now.to_i,
        exp: (Time.now + 1.day).to_i
      }

      secret = Rails.application.secrets.secret_key_base

      jwt = JWT.encode result, secret, 'HS256'

      jwt
    end
  end
end