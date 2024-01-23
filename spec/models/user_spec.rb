# frozen_string_literal: true

require "rails_helper"

RSpec.describe(User, type: :model) do
  context "user.emailとuser.usernameのunique制約に対するテスト" do
    it "unique both" do
      expect(FactoryBot.build(:user)).to(be_valid)
    end

    it "email is not unique" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.build(:user, email: user1.email)
      expect(user2).to(be_invalid)
    end

    it "username is not unique" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.build(:user, username: user1.username)
      expect(user2).to(be_invalid)
    end
  end
end
