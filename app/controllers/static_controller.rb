class StaticController < ApplicationController
  before_filter :authenticate_request!
  skip_before_action :verify_authenticity_token, only[:test]
  def test
  end
end
