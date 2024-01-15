module EmailErrorReporter
  class Engine < ::Rails::Engine
    isolate_namespace EmailErrorReporter

    config.email_error_reporter = ActiveSupport::OrderedOptions.new
    config.email_error_reporter.to = []
    config.email_error_reporter.from = "no-reply@example.com"
    config.email_error_reporter.enabled = true

    initializer "email_error_reporter.error_subscribe" do |app|
      if app.config.email_error_reporter.enabled
        Rails.error.subscribe(Subscriber.new)
      end
    end

    # ActiveJob cannot (de)-serialize exceptions by default
    initializer "email_error_reporter.exception_serializer" do |app|
      app.config.active_job.custom_serializers << ExceptionSerializer
    end
  end
end
