module Tokens
  class GenerateFromLogin < ActiveInteraction::Base
    string :email
    string :password

    def execute
      user = User.find_by_email email
      if user
        if user.valid_password?(password)
          user.get_jwt
        else
          errors.add(:login, "is incorrect")
        end
      else
        errors.add(:login, "is incorrect")
      end
    end
  end
end