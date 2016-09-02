class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    render 'shared/not_authorized'
  end
end
