# == Schema Information
#
# Table name: boxes
#
#  id            :integer          not null, primary key
#  token         :string
#  user_id       :integer
#  title         :string
#  privacy_level :integer
#  box_language  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_boxes_on_token    (token) UNIQUE
#  index_boxes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_6e9f17f192  (user_id => users.id)
#

class Box < ApplicationRecord
  belongs_to :user
  has_many :snippets, dependent: :destroy
  before_create :set_token

  scope :open, -> { where(privacy_level: 2) }

  enum privacy_level: [:locked, :unlisted, :open]

  def jwt
    current_user ||= User.first
    payload = {
      token: self.token
    }
    Tokens::Generate.run(type: 'box', resource_token: self.token, user_token: self.user.token).result
  end

  private

  def set_token
    self.token = ULID.generate
  end
end
