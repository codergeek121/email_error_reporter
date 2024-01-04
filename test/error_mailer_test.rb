require "test_helper"

class EmailErrorReporter::ErrorMailerTest < ActionMailer::TestCase
  setup do
    @exception = Exception.new("some message")
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

  test "email content" do
    @exception.set_backtrace(["foo", "bar"])
    email = error_mail(handled: true, severity: :info).deliver_now
    assert_dom_email do
      assert_dom "h1", "Exception"
      assert_dom "h2", "some message"
      assert_dom test_id("source"), "Source: No source present"
      assert_dom test_id("handled"), "Handled: ✅"
      assert_dom test_id("context"), "{}"
      assert_dom "table" do
        assert_dom "tr", 2
      end
    end
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

  def test_id(value)
    "[data-test-id='#{value}']"
  end
end
