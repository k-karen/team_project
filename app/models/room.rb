# frozen_string_literal: true

class Room < ApplicationRecord
  attr_accessor :user_ids # for form
  attr_accessor :retention_hours # for room

  # Roomを消したときに、そのRoomに紐づくMessageも一緒に消えるようにする
  has_many :messages, dependent: :destroy

  has_and_belongs_to_many :users

  broadcasts_to ->(_room) { :rooms }, inserts_by: :prepend
  after_create_commit  { broadcast_prepend_to 'rooms' }
  after_update_commit  { broadcast_prepend_to 'rooms' }
  after_destroy_commit { broadcast_remove_to 'rooms' }
end
