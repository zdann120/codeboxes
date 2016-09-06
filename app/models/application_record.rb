class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_jwt
    Tokens::Generate.run(
      type: self.class.name,
      resource_token: self.token,
      user_token: User.first.token
    ).result
  end
end
