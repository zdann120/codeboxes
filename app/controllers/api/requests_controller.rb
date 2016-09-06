class Api::RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_headers, except: [:login]
  def test
    render json: @result
  end

  def boxes
    @result ||= [{'user_token': nil}]
    @user = User.find_by_token @result[0]['user_token']
    @boxes = @user.boxes
    render 'boxes', formats: :json
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

  def login
    @email = params[:email]
    @password = params[:password]
    result = Tokens::GenerateFromLogin.run(email: @email, password: @password)
    if result.valid?
      render json: { token: result.result }
    else
      render json: { errors: result.errors.full_messages.to_s }
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
