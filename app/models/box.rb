class Box < ApplicationRecord
  belongs_to :user
  has_many :snippets
  before_create :set_token

  enum privacy_level: [:locked, :unlisted, :open]

  private

  def set_token
    self.token = ULID.generate
  end
end
