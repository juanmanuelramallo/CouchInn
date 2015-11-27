class MessagesController < ApplicationController
  def index

    @messages = Message.where('user_id = ?', current_user.id)

    @messages.each do |m|
      m.seen = false
      m.save
    end

  end


end
