class ErrorMailerPreview < ActionMailer::Preview
  def error
    EmailErrorReporter::ErrorMailer.error(
      Exception.new('foo'), 
      handled: true,
      severity: :info,
      context: {}
    )
  end

  def error_with_backtrace
    EmailErrorReporter::ErrorMailer.error(
      Exception.new('foo').tap { _1.set_backtrace(["foo", "bar"])}, 
      handled: true,
      severity: :error,
      context: {}
    )
  end
end
