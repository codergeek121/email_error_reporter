module EmailErrorReporter
  class Subscriber
    def report(error, handled:, severity:, context:, source: nil)
      ErrorMailer.error(error, handled: handled, context: context, source: source).deliver_later
    end
  end
end
