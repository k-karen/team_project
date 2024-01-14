# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to(root_path, notice: "ログイン済みです") if logged_in?
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: "Login successful")
    else
      flash[:alert] = "ログインに失敗しました"
      redirect_to(action: :new)
    end
  end

  def destroy
    logout
    flash[:notice] = "ログアウトしました"
    redirect_to(root_path)
  end
end
