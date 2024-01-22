# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to(root_path, notice: "Already logged in") if logged_in?
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: "Login successful")
    else
      flash[:alert] = "login failed"
      redirect_to(action: :new)
    end
  end

  def destroy
    logout
    flash[:notice] = "logged out"
    redirect_to(root_path)
  end
end
