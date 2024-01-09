# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  # ステータス値を定義
  enum status: { pending: 0, accepted: 10, declined: 90 }
end
