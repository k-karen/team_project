# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Rooms", type: :request) do
  describe "login user" do
    before do
      @user = FactoryBot.create(:user, :activated, :with_friends)
      post login_path, params: { email: @user.email, password: "aiit-password" }
    end

    describe "POST /room" do
      it "creates a room and redirects to the room's page" do
        post rooms_path, params: { room: { name: "test-room", retention_minutes: 1, retention_hours: 1 } }
        expect(Room.last.name).to(eq("test-room"))
        expect(Room.last.retention_minutes).to(eq(61))
      end
    end
  end
end
