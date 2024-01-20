# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def test
    x = (1..100).to_a.sample(3)
    render(json: { message: "Hello World #{x}" })
  end

  def require_login
    redirect_to(login_path, alert: "ログインしてください") unless logged_in?
  end

  def record_not_found(_execption)
    render("errors/404", status: :forbidden)
  end
end
