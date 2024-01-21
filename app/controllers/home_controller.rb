# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @rooms = if current_user
      current_user.rooms.order(updated_at: :desc)
    else
      []
    end
  end

  # デプロイ済みのrevisionを確認するAPIです
  def current_rev
    render(json: { current_rev: ENV.fetch("CURRENT_REVISION", nil) })
  end

  def not_found
    render(json: { path: params[:not_found_path] }, status: :not_found)
  end
end
