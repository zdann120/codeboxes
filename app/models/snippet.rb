# == Schema Information
#
# Table name: snippets
#
#  id         :integer          not null, primary key
#  box_id     :integer
#  token      :string
#  haiku      :string
#  title      :string
#  code       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  language   :string
#  expires    :boolean          default(FALSE)
#  expiration :datetime
#
# Indexes
#
#  index_snippets_on_box_id  (box_id)
#  index_snippets_on_haiku   (haiku) UNIQUE
#  index_snippets_on_slug    (slug) UNIQUE
#  index_snippets_on_token   (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_ff583d8192  (box_id => boxes.id)
#

class Snippet < ApplicationRecord
  extend FriendlyId
  friendly_id :haiku, use: [:slugged, :finders]
  belongs_to :box
  before_create :set_token
  before_create :set_haiku
  
  def show_language
    @lang = self.language
    @lang ||= self.box.box_language
    @lang
  end

  private

  def set_token
    self.token = ULID.generate
  end

  def set_haiku
    self.haiku = Haikunator.haikunate(9999, '-')
  end
end
