# frozen_string_literal: true

class Room < ApplicationRecord
  attr_accessor :user_ids # for form
  attr_accessor :retention_hours # for room

  # Roomを消したときに、そのRoomに紐づくMessageも一緒に消えるようにする
  has_many :messages, dependent: :destroy

  has_and_belongs_to_many :users
  has_one_attached :image

  after_create_commit do |room|
    room.users.pluck(:id).each do |user_id|
      broadcast_prepend_to "user_#{user_id}_rooms", partial: "rooms/room", target: "user_#{user_id}_rooms"
    end
  end
  after_update_commit do |room|
    room.users.pluck(:id).each do |user_id|
      broadcast_prepend_to "user_#{user_id}_rooms", partial: "rooms/room", target: "user_#{user_id}_rooms"
    end
  end
  before_destroy do |room|
    room.users.pluck(:id).each do |user_id|
      broadcast_remove_to "user_#{user_id}_rooms"
    end
  end
end
