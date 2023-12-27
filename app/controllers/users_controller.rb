# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(login_path, notice: "User was successfully created. Please check your email to activate.")
    else
      render(:new)
    end
  end

  def activate
    if (user = User.load_from_activation_token(params[:token]))
      user.activate!
      auto_login(user)
      redirect_to(root_path, notice: "Your account has been activated successfully!")
    else
      redirect_to(root_path, alert: "Invalid activation code")
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end
