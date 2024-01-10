# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def activation_needed_email(user)
    @user = user
    @url  = "http://localhost:3000/activate?token=#{@user.activation_token}"
    mail(to: user.email, subject: "Welcome to My Awesome Site") if Rails.env.development?
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: "Activation success") if Rails.env.development?
  end
end
