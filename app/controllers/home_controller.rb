# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @rooms = if current_user
      current_user.rooms
        .left_joins(:messages)
        .group("rooms.id")
        .order("max(messages.created_at) DESC, rooms.id desc")
    else
      []
    end
  end

  # デプロイ済みのrevisionを確認するAPIです
  def current_rev
    render(json: { current_rev: ENV.fetch("CURRENT_REVISION", nil) })
  end
end
