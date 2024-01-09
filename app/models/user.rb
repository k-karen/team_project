# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one :user_profile, dependent: :destroy
end
