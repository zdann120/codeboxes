class Snippet < ApplicationRecord
  extend FriendlyId
  friendly_id :haiku, use: [:slugged, :finders]
  belongs_to :box
  before_create :set_token
  before_create :set_haiku

  private

  def set_token
    self.token = ULID.generate
  end

  def set_haiku
    self.haiku = Haikunator.haikunate(9999, '-')
  end
end
