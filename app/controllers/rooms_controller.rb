# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @room = current_user.rooms.find(params[:id])
    # nilだった場合は、すべてのメッセージを表示
    @messages = if @room.retention_minutes.present?
      @room.messages.where("created_at >= ?", @room.retention_minutes.minutes.ago)
    else
      @room.messages
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    # 選択されたフレンドと自分を紐づけてroomを作る
    @room = Room.new(room_params)
    @users = current_user.friends.where(id: room_user_params[:user_ids])
    @room.users.append([current_user, *@users])

    total_minutes = (@room.retention_hours.to_i * 60) + @room.retention_minutes.to_i
    @room.retention_minutes = total_minutes

    respond_to do |format|
      if @room.save
        format.html { redirect_to(room_url(@room), notice: "Room was successfully created.") }
        format.json { render(:show, status: :created, location: @room) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @room.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to(room_url(@room), notice: "Room was successfully updated.") }
        format.json { render(:show, status: :ok, location: @room) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @room.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to(root_url, notice: "Room was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name, :retention_minutes, :retention_hours)
  end

  def room_user_params
    params.require(:room).permit(user_ids: [])
  end
end
