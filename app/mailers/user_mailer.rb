# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = activate_url(token: @user.activation_token)
    mail(to: user.email, subject: "Welcome to My Awesome Site")
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: "Activation success")
  end
end
