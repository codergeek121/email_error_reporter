desc "Report a test exception"
namespace :email_error_reporter do
  task check: :environment do
    Rails.error.handle { raise "This is a test!" }
    $stdout.puts <<~TXT
      Test exception triggered.

      Recipients:
      #{Rails.application.config.email_error_reporter.to.join("\n").gsub(/^/, "* ")}
    TXT
  end
end
