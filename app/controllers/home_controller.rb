# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @rooms = current_user&.rooms
  end
end
