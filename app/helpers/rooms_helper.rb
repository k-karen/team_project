# frozen_string_literal: true

module RoomsHelper
  def my_room_list_stream
    "user_#{current_user.id}_rooms"
  end
end
