class Admin::NewUser < ActiveInteraction::Base
  string :email
  string :password

  validates :email, presence: true
  validates :password, presence: true

  def execute
    user = User.new(email: email, password: password)
    errors.merge!(user.errors) unless user.save
    return user unless user.persisted?
    box = user.boxes.new(title: 'My First Box', box_language: 'text', privacy_level: 0)
    box.save
    user
  end
end