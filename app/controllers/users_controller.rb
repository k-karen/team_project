# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit_settings, :update_settings, :edit_profile, :update_profile]
  def new
    @user = User.new
  end

  def show
    @user = if params[:id] == current_user.id.to_s
      current_user
    else
      current_user.friends.find(params[:id])
    end
  end

  def create
    @user = User.new(user_settings_params)
    if @user.save
      redirect_to(login_path, notice: "User was successfully created. Please check your email to activate.")
    else
      flash.now[:alert] = "Invalid email/password combination"
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

  def edit_settings
    @user = current_user
  end

  def update_settings
    @user = current_user
    if @user.update(user_settings_params)
      flash[:notice] = "Settings updated"
      redirect_to(@user)
    else
      flash[:alert] = "Failed to update settings"
      render(:edit_settings)
    end
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_profile_params)
      flash[:notice] = "Profile updated"
      redirect_to(@user)
    else
      flash[:alert] = "Failed to update profile"
      render(:edit_profile)
    end
  end

  private

  def user_settings_params
    params.require(:user).permit(:email, :password, :username)
  end

  def user_profile_params
    params.require(:user).permit(:biography, :birthday, :icon)
  end

  # beforeフィルタ

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:alert] = "Please log in."
      redirect_to(login_url, status: :see_other)
    end
  end
end
