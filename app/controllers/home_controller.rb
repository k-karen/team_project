# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @rooms = Room.all # TODO: 自分に紐づいているroomのみを表示する
  end
end
