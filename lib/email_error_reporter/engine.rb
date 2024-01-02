module EmailErrorReporter
  class Engine < ::Rails::Engine
    isolate_namespace EmailErrorReporter

    config.email_error_reporter = ActiveSupport::OrderedOptions.new
    config.email_error_reporter.to = []

    initializer "email_error_reporter.error_subscribe" do
      Rails.error.subscribe(Subscriber.new)
    end

    # ActiveJob cannot (de)-serialize exceptions by default
    initializer "email_error_reporter.exception_serializer" do |app|
      app.config.active_job.custom_serializers << ExceptionSerializer
    end
  end
end
