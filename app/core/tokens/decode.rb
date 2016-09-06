module Tokens
  class Decode < ActiveInteraction::Base
    string :token

    def execute
      JWT.decode token, Rails.application.secrets.secret_key_base
    end
  end
end