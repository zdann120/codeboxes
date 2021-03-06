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

class SnippetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @snippet = snippets(:one)
  end

  test "should get index" do
    get snippets_url
    assert_response :success
  end

  test "should get new" do
    get new_snippet_url
    assert_response :success
  end

  test "should create snippet" do
    assert_difference('Snippet.count') do
      post snippets_url, params: { snippet: { box_id: @snippet.box_id, code: @snippet.code, haiku: @snippet.haiku, title: @snippet.title, token: @snippet.token } }
    end

    assert_redirected_to snippet_url(Snippet.last)
  end

  test "should show snippet" do
    get snippet_url(@snippet)
    assert_response :success
  end

  test "should get edit" do
    get edit_snippet_url(@snippet)
    assert_response :success
  end

  test "should update snippet" do
    patch snippet_url(@snippet), params: { snippet: { box_id: @snippet.box_id, code: @snippet.code, haiku: @snippet.haiku, title: @snippet.title, token: @snippet.token } }
    assert_redirected_to snippet_url(@snippet)
  end

  test "should destroy snippet" do
    assert_difference('Snippet.count', -1) do
      delete snippet_url(@snippet)
    end

    assert_redirected_to snippets_url
  end
end
