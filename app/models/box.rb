class Box < ApplicationRecord
  belongs_to :user
  has_many :snippets, dependent: :destroy
  before_create :set_token

  scope :open, -> { where(privacy_level: 2) }

  enum privacy_level: [:locked, :unlisted, :open]

  private

  def set_token
    self.token = ULID.generate
  end
end
