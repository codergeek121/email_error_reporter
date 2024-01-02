module EmailErrorReporter
  class ErrorMailer < ActionMailer::Base
    def error(error, handled:, severity:, context:, source: nil)
      @error = error
      @handled = handled
      @severity = severity
      @context = context
      @source = source

      @backtrace = Array.wrap(error.backtrace)

      mail(
        subject: "#{error.class}",
        to: Rails.application.config.email_error_reporter.to
      )
    end
  end
end
