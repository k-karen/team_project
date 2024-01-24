# frozen_string_literal: true

module RoomsHelper
  def my_room_list_stream
    "user_#{current_user.id}_rooms"
  end

  def format_date(created_time)
    current_date = Time.now.in_time_zone.to_date
    if created_time.to_date == current_date
      # 今日の場合、hh:mm形式で出力
      created_time.strftime("%H:%M")
    else
      # それ以外の場合、mm/dd形式で出力
      created_time.strftime("%m/%d")
    end
  end
end
