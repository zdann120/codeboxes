class TokensController < ApplicationController
  require 'jwt'
  before_action :authenticate_user!

  def show
    @user = current_user
    @token = current_user.jwt
  end

  def validate
    @token = params[:token]
    check_token
    if @user
      @status = "VALID"
    else
      @status = "INVALID"
    end
  end

  private

  def check_token
    hmac_secret = Rails.application.secrets.secret_key_base
    @result = JWT.decode @token, hmac_secret, 'HS256'
    user_id = @result[0]["user"]
    @user = User.find(user_id)
  end
end
