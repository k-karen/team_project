# frozen_string_literal: true

class Room < ApplicationRecord
  attr_accessor :user_ids # for form

  # Roomを消したときに、そのRoomに紐づくMessageも一緒に消えるようにする
  has_many :messages, dependent: :destroy
  broadcasts

  has_and_belongs_to_many :users
end
