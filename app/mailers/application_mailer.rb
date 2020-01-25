class ApplicationMailer < ActionMailer::Base
  default from: ENV['APP_NAME'] ||= 'from@example.com'
  layout 'mailer'
end
