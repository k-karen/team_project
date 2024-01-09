# frozen_string_literal: true

class Room < ApplicationRecord
  # Roomを消したときに、そのRoomに紐づくMessageも一緒に消えるようにする
  has_many :messages, dependent: :destroy
  broadcasts
end
