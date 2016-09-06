module Tokens
  class Generate < ActiveInteraction::Base
    string :type
    hash :payload

    def execute
      data = {
        key_type: type,
        jti: ULID.generate,
        iat: Time.now.to_i,
        exp: (Time.now + 1.day).to_i
      }

      result = data.merge(payload)

      secret = Rails.application.secrets.secret_key_base

      jwt = JWT.encode result, secret, 'HS256'

      jwt
    end
  end
end