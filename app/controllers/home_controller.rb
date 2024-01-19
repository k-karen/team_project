# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @rooms = if current_user
      current_user.rooms
        .left_joins(:messages)
        .group("rooms.id")
        .order(
          Arel.sql("CASE WHEN COUNT(messages.id) = 0
            THEN rooms.created_at ELSE MAX(messages.created_at) END DESC, rooms.id DESC"),
        )
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
