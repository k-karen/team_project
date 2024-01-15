# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_room, only: [:new, :create]
  before_action :require_login

  def new
    @message = @room.messages.new
  end

  def create
    # 新しいメッセージを作成し、現在ログインしているユーザーに関連付ける
    @message = @room.messages.new(message_params)
    @message.user = current_user if logged_in?

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to(@room) }
      end
    else
      # saveに失敗した場合、ユーザーに再度入力をしてもらう
      flash[:alert] = "Message could not be saved. Please try again."
      redirect_to(new_room_message_path(@room))
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
