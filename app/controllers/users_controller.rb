# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(login_path, notice: "User was successfully created. Please check your email to activate.")
    else
      flash.now[:danger] = "Invalid email/password combination"
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to(@user)
    else
      render(:edit)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  # beforeフィルタ

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to(login_url, status: :see_other)
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless @user == current_user
  end
end
