class Snippet < ApplicationRecord
  belongs_to :box
  before_create :set_token
  before_create :set_haiku

  private

  def set_token
    self.token = ULID.generate
  end

  def set_haiku
    self.haiku = Haikunator.haikunate(1000, '-')
  end
end
