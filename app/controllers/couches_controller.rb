class CouchesController < ApplicationController
  before_action :get_couch, only:[:edit, :update, :destroy, :show]

  def get_couch
    @couch = Couch.find(params[:id])
  end

  def get_id
    @c_id = Couch.id
  end

  def create
    couch = Couch.create(params.require(:tipo, :capacidad).permit(:ubicacion, :descripcion));

    couch.usuario_id = current_user.id;

    redirect_to couch

  end

  def index
  end

  def default
  end

  def show

  end
end
