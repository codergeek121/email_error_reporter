require "test_helper"

class SubscriberTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  TestError = Class.new(StandardError)

  test "enqueues a mail with the reported error" do
    Rails.error.record(TestError) do
      raise TestError
    end

  rescue TestError => e
    # matcher
    assert_enqueued_with(
      job: ActionMailer::MailDeliveryJob,
      args: ->(j) {
        [
          "EmailErrorReporter::ErrorMailer" == j[0],
          "error" == j[1],
          "deliver_now" == j[2],
          e.class == j[3][:args][0].class,
          { handled: false, context: {}, severity: :error, source: rails_default_source } == j[3][:args][1],
        ].all?
      }
    )
  end

  private

  def rails_default_source
    if Gem::Version.new(Rails.version) >= Gem::Version.new("7.1.0")
      "application"
    else
      nil
    end
  end
end
