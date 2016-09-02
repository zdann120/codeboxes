require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "new_account" do
    mail = UserMailer.new_account
    assert_equal "New account", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
