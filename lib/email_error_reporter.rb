require "email_error_reporter/version"
require "email_error_reporter/engine"

module EmailErrorReporter
  extend ActiveSupport::Autoload

  autoload :ErrorMailer
  autoload :Subscriber
  autoload :ExceptionSerializer
end
