class User::DirectMessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]
  
  def create
    if params[:direct_message].present? && Entry.where(user_id: current_user.id, room_id: params[:direct_message][:room_id]).present?
      @direct_message = DirectMessage.create(direct_message_params.merge(user_id: current_user.id))
      redirect_to "/rooms/#{params[:direct_message][:room_id]}"
    else
      # エラー処理など
    end
  end
  
  def direct_message_params
    params.require(:direct_message).permit(:message, :user_id, :room_id)
  end

end
