class UsersController < ApplicationController

  def index
    if user_signed_in?
      @user = current_user
      @couches = Couch.all.where('user_id = ?', current_user.id)
    else
      redirect_to root_path
    end
  end

  def profile
    @user = User.find(params[:id])
    if current_user.has_confirmed_reservation_with?(@user)
      @couches = @user.couches
    else
      redirect_to root_path, alert: "No tienes los permisos para ver esa página, pero sí para seguir viendo couches!"
    end
  end

end
