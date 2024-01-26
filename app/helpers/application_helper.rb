# frozen_string_literal: true

module ApplicationHelper
  def render_room_image(room, options: {}, size: [80, 80])
    if room&.image&.attached?
      image_tag(room.image.variant(resize_to_limit: size), { alt: "room-image" }.merge(options))
    else
      image_tag("/assets/default_room_image.png", { alt: "room-image" }.merge(options))
    end
  end

  def render_user_icon(user, options: {}, size: [80, 80])
    if user&.icon&.attached?
      image_tag(user.icon.variant(resize_to_limit: size), { alt: "user-icon" }.merge(options))
    else
      image_tag("/assets/default_user_icon.png", { alt: "user-icon" }.merge(options))
    end
  end
end
