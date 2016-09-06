class Api::SnippetsController < ApplicationController
  before_action :check_headers
  def test
    # check_headers
  end

  def boxes
    @result ||= [{'user_token': nil}]
    @user = User.find_by_token @result[0]['user_token']
    @boxes = @user.boxes
    render json: { boxes: @boxes }
  end

  private

  def check_headers
    if request.headers['HTTP_AUTHORIZATION'].present?
      @token = request.headers['HTTP_AUTHORIZATION'].split(' ')[1].to_s
      # pry
      @result = Tokens::Decode.run(token: @token).result

      # render json:  @result[0]
    else
      render json: {msg: 'No authorization header found.'}
      nil
    end
  rescue JWT::DecodeError
    # render json: {error: 'Could not be decoded.'}
    render json: { error: 'An error occurred.' }
  end
end
