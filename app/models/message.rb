# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :room, touch: true # メッセージ投稿時にroomのupdated_atを更新する
  belongs_to :user
  broadcasts_to :room
  has_many :reactions
end
