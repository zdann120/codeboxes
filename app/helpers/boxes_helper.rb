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

module BoxesHelper
end
