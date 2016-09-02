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

require 'test_helper'

class BoxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @box = boxes(:one)
  end

  test "should get index" do
    get boxes_url
    assert_response :success
  end

  test "should get new" do
    get new_box_url
    assert_response :success
  end

  test "should create box" do
    assert_difference('Box.count') do
      post boxes_url, params: { box: { box_language: @box.box_language, privacy_level: @box.privacy_level, title: @box.title, token: @box.token, user_id: @box.user_id } }
    end

    assert_redirected_to box_url(Box.last)
  end

  test "should show box" do
    get box_url(@box)
    assert_response :success
  end

  test "should get edit" do
    get edit_box_url(@box)
    assert_response :success
  end

  test "should update box" do
    patch box_url(@box), params: { box: { box_language: @box.box_language, privacy_level: @box.privacy_level, title: @box.title, token: @box.token, user_id: @box.user_id } }
    assert_redirected_to box_url(@box)
  end

  test "should destroy box" do
    assert_difference('Box.count', -1) do
      delete box_url(@box)
    end

    assert_redirected_to boxes_url
  end
end
