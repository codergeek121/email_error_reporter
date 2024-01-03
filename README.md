# EmailErrorReporter

> [!CAUTION]
> This is a very early prototype

`email_error_reporter` uses the new [Rails error reporting API](https://guides.rubyonrails.org/error_reporting.html#error-reporting) to send emails whenever an exception is being reported. It works out of the box with HTTP requests, jobs and the rails runner.

## Installation

Add the gem:

```bash
bundle add email_error_reporter && bundle install
```

and configure the email addresses that should receive an email in the case of an exception:

```ruby
# application.rb
config.email_error_reporter.to = ["youremail@example.com"]
```

`email_error_reporter` will reuse your environment specific ActionMailer configuration for delivering emails.

## Usage

All exceptions are reported automatically. No additional code required.

Please consult the [official guides](https://guides.rubyonrails.org/error_reporting.html) for an introduction to the error reporting API.

## Test your setup

You can use the built-in rake task `rake email_error_reporter:check` to check if everything works correctly in your setup.

If you're using Kamal, you can run the following command to test the setup in production:

```
kamal app exec -p 'bundle exec rake email_error_reporter:test_email'
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
