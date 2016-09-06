class TokensController < ApplicationController
  require 'jwt'

  before_action :authenticate_user!, except: [:validate]

  rescue_from JWT::DecodeError, with: :unprocessable_token

  def show
    @user = current_user
    @token = current_user.jwt
    @decode = Tokens::Decode.run(token: @token).result
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
    @result = Tokens::Decode.run(token: @token).result
    user_token ||= @result[0]["token"]
    @user = User.find_by_token(user_token)
  end

  def unprocessable_token
    redirect_to root_url, notice: 'This is not a valid token.'
  end
end
