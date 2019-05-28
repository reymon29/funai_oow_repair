require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "label" do
    mail = OrderMailer.label
    assert_equal "Label", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

    test "invoice" do
    mail = OrderMailer.invoice
    assert_equal "Invoice", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
