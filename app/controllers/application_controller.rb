# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def test
    x = (1..100).to_a.sample(3)
    render(json: { message: "Hello World #{x}" })
  end

  def require_login
    redirect_to(login_path, alert: "ログインしてください") unless logged_in?
  end
end
