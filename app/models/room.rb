# frozen_string_literal: true

class Room < ApplicationRecord
  # Roomを消したときに、そのRoomに紐づくMessageも一緒に消えるようにする
  has_many :messages, dependent: :destroy
  broadcasts

  has_many :room_users
  has_many :users, through: :room_users
end
