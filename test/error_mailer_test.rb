require "test_helper"

class EmailErrorReporter::ErrorMailerTest < ActionMailer::TestCase
  test "renders the template correctly" do
    exception = Exception.new("some message")
    email = EmailErrorReporter::ErrorMailer.error(
      exception,
      handled: true,
      severity: :info,
      context: {}
    )
    assert_equal [], email.to
    assert_equal "Exception", email.subject
    assert_equal read_fixture("error").join, email.body.to_s
  end

  test "renders a backtrace" do
    exception = Exception.new("some message")
    exception.set_backtrace(["foo", "bar"])
    email = EmailErrorReporter::ErrorMailer.error(
      exception,
      handled: true,
      severity: :info,
      context: {}
    )
    assert_equal [], email.to
    assert_equal "Exception", email.subject
    assert_equal read_fixture("error_with_backtrace").join, email.body.to_s
  end
end
