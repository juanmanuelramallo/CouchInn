class UsersController < ApplicationController

  def set_rol_to_premium
    self.rol ||= :premium
  end

  def notificacion
  	#@user = User.find(14)
  	@user = current_user
  end

end
