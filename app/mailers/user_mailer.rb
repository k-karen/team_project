class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def activation_needed_email(user)
    @user = user
    @url  = "http://localhost:3000/users/#{user.activation_token}/activate"
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: 'Activation success')
  end
end
