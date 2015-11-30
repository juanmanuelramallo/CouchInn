class UsersController < ApplicationController

  def index
    @user = current_user
    @couches = Couch.all.where('user_id = ?', current_user.id)
  end

end