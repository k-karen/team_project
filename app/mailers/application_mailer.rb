# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{ENV.fetch("MAIL_DOMAIN", "example.com")}"
  layout "mailer"
end
