class UsersController < ApplicationController

  def index
    if user_signed_in?
      @user = current_user
      @couches = Couch.all.where('user_id = ?', current_user.id)
    else
      redirect_to root_path
    end
  end

end
