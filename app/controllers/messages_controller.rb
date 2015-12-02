class MessagesController < ApplicationController
  def index
    if user_signed_in?
      @messages = Message.where('user_id = ?', current_user.id)
    else
      redirect_to root_path
    end
  end


end
