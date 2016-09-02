class Admin::NewUser < ActiveInteraction::Base
  string :email
  string :password

  validates :email, presence: true
  validates :password, presence: true

  def execute
    return errors.add(:user, 'already exists') if User.find_by_email(email)
    create_user
    new_box
  end

  private

    def new_box
      @box = @user.boxes.new(title: 'My First Box', box_language: 'text', privacy_level: 0)
      @box.save
    end

    def create_user
      @token = nil

      @user = User.invite!(:email => email, :password => password, :skip_invitation => true)
      errors.merge!(@user.errors) unless @user.save
      UserMailer.new_account(@user.invitation_token, email).deliver_now
      @user.deliver_invitation
      return @user unless @user.persisted?
    end
end