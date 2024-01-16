# frozen_string_literal: true

class Room < ApplicationRecord
  attr_accessor :user_ids # for form

  # Roomを消したときに、そのRoomに紐づくMessageも一緒に消えるようにする
  has_many :messages, dependent: :destroy
  # REVIEW: broadcast_prepend_toを動かすために、コメントアウトしたが、エラーがおきるかも
  # broadcasts

  has_and_belongs_to_many :users
  after_create_commit { broadcast_prepend_to "rooms" }
end
