# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    # ログインフォームの表示
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: "Login successful")
    else
      flash.now[:alert] = "Login failed"
      render(:new)
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: "Logged out")
  end
end