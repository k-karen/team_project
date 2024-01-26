# frozen_string_literal: true

# app/models/user.rb

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :messages

  has_many :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :friends, through: :friendships, source: :friend
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_and_belongs_to_many :rooms

  has_one_attached :icon

  validates :email, uniqueness: true
  validates :username, uniqueness: true
end
