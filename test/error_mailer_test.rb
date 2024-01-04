require "test_helper"

class EmailErrorReporter::ErrorMailerTest < ActionMailer::TestCase
  setup do
    @exception = Exception.new("some message")
  end

  test "renders the template correctly" do
    assert_equal [], error_mail.to
    assert_equal read_fixture("error").join, error_mail.body.to_s
  end

  test "renders a backtrace" do
    @exception.set_backtrace(["foo", "bar"])

    assert_equal [], error_mail.to
    assert_equal read_fixture("error_with_backtrace").join, error_mail.body.to_s
  end

  test "severity: error" do
    email = error_mail(severity: :error)
    assert_equal "🔥" + "  Exception", email.subject
  end

  test "severity: warning" do
    email = error_mail(severity: :warning)
    assert_equal "⚠️" + "  Exception", email.subject
  end

  test "severity: info" do
    email = error_mail(severity: :info)
    assert_equal "ℹ️" + "  Exception", email.subject
  end

  private

  def error_mail(**kwargs)
    email = EmailErrorReporter::ErrorMailer.error(
      @exception,
      handled: true,
      severity: :info,
      context: {},
      **kwargs
    )
  end
end
