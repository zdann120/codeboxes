class StaticController < ApplicationController
  before_filter :authenticate_request!
  
  def test
  end
end
