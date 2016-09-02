class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_account.subject
  #
  def new_account(token, email)
    @token = token
    @email = email

    mail to: @email, subject: 'Your CodeBoxes Account', from: 'accounts@zachapps.com'
  end
end
