class Api::RequestsController < ApplicationController
  before_action :check_headers
  def test
    render json: @result
  end

  def boxes
    @result ||= [{'user_token': nil}]
    @user = User.find_by_token @result[0]['user_token']
    @boxes = @user.boxes
    render json: { boxes: @boxes }
  end

  def snippets
    @box = @resource_class.find_by_token(@resource_token)
    if @box
      @snippets = @box.snippets
      render json: @snippets
    else
      render json: { errors: 'Token does not point to a valid code box.' }
    end
  end

  private

  def check_headers
    if request.headers['HTTP_AUTHORIZATION'].present?
      @token = request.headers['HTTP_AUTHORIZATION'].split(' ')[1].to_s
      @result = Tokens::Decode.run(token: @token).result
      @resource_token = @result[0]['token']
      @resource_class = @result[0]['key_type'].constantize
    else
      render json: {msg: 'No authorization header found.'}
    end
  rescue JWT::DecodeError
    render json: { error: 'An error occurred.' }
  end
end
