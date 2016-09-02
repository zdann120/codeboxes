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

require 'test_helper'

class SnippetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
