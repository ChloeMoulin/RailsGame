require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "inscription" do
    mail = Notifier.inscription
    assert_equal "Inscription", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
