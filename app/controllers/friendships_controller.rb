# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :require_login

  def index
    @friends = current_user.friends
  end

  def create
    @friend = User.find_by(username: params[:username])
    if @friend && current_user.friends.append(@friend)
      respond_to do |format|
        format.html { redirect_to(friendships_path) }
        format.turbo_stream
      end
    else
      redirect_to(friendships_path, alert: "Unable to create friendship.")
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.friendships.find_by(friend_id: @user.id).destroy
    respond_to do |format|
      format.html { redirect_to(friendships_path) }
      format.turbo_stream
    end
  end
end
