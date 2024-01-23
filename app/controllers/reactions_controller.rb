class ReactionsController < ApplicationController
  before_action :set_message

  def create
    reaction = @message.reactions.new(reaction_params)
    if reaction.save
      render json: reaction, status: :created
    else
      render json: reaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    reaction = @message.reactions.find(params[:id])
    reaction.destroy
    head :no_content
  end

  private

  def set_message
    @message = Message.find(params[:message_id])
  end

  def reaction_params
    params.require(:reaction).permit(:user_id, :reaction_type)
  end
end
