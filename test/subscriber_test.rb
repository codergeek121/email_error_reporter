require "test_helper"

class SubscriberTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  TestError = Class.new(StandardError)

  test "enqueues a mail with the reported error" do
    Rails.error.record(TestError) do
      raise TestError
    end

  rescue TestError => e
    assert_enqueued_email_with EmailErrorReporter::ErrorMailer, :error, args: ->(args) {
      # TODO: find out, why args.first == e is false
      [
        args.first.message == e.message,
        args.first.backtrace == e.backtrace,
        args.first.class == e.class
      ].all?
    }
  end
end
