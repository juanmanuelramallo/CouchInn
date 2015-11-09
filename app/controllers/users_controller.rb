class UsersController < ApplicationController

  def set_rol_to_premium
    self.rol ||= :premium
  end

end
