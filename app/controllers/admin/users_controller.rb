class Admin::UsersController < ApplicationController
  before_action :authorize_admin
  def index
    @users = User.all
  end

  def new
    @user = Admin::NewUser.new
  end

  def create
    @user = Admin::NewUser.run(user_params.to_h)
    if @user.valid?
      redirect_to admin_users_url, notice: "#{@user} added!"
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:admin_new_user).permit(:email, :password)
    end

    def authorize_admin
      authorize :admin, :show?
    end
end
