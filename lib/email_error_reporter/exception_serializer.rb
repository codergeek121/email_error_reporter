module EmailErrorReporter
  class ExceptionSerializer < ActiveJob::Serializers::ObjectSerializer
    def serialize(exception)
      super(
        exception_class: exception.class.to_s,
        message: exception.message,
        backtrace: exception.backtrace
      )
    end

    def deserialize(hash)
      hash[:exception_class].constantize.new(hash[:message]).tap do |e|
        e.set_backtrace(hash[:backtrace])
      end
    end

    private

    def klass
      Exception
    end
  end
end
