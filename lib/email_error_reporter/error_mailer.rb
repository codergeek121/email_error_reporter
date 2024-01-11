module EmailErrorReporter
  class ErrorMailer < ActionMailer::Base
    def error(error, handled:, severity:, context:, source: nil)
      @error = error
      @handled = handled
      @severity = severity
      @context = context
      @source = source

      @backtrace = Array.wrap(error.backtrace)

      severity_to_emoji = {
        error: "🔥",
        warning: "⚠️",
        info: "ℹ️"
      }

      mail(
        subject: "#{severity_to_emoji.fetch(@severity)}  #{error.class}",
        from: Rails.application.config.email_error_reporter.from,
        to: Rails.application.config.email_error_reporter.to
      )
    end
  end
end
