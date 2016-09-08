class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_jwt(user = User.first)
    Tokens::Generate.run(
      type: self.class.name,
      resource_token: self.token,
      user_token: user.token,
      expires_in: 60 * 60
    ).result
  end
end
