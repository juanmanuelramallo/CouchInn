class CouchesController < ApplicationController

  before_action :get_couch, only:[:edit, :update, :destroy, :show]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  #attr_accessible :ubicacion, :descripcion, :tipo, :capacidad

  def get_couch
    @couch = Couch.find(params[:id])
  end

  def get_id
    @c_id = Couch.id
  end

  def index
    @couch = Couch.all
  end

  def show

  end

  def new
    @couch = Couch.new
  end

  #protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:new) << :ubicacion
  end

  def create
  @couch = Couch.create(params.require(:couch).permit(:usuario_id, :tipo,:ubicacion, :descripcion, :capacidad))

   respond_to do |format|
      if @couch.save
         format.html { redirect_to @couch, notice: "El couch fue creado correctamente." }
         format.json { render :show, status: :created, location: @couch }
      else
         format.html { render :new }
         format.json { render json: @couch.errors, status: :unprocessable_entity }
      end
   end
end

#def create
    #@couch = Couch.create(params[:couches])
    #@couch = Couch.create(params.requiere(:ubicacion, :descripcion))
    #@couch = Couch.create(params.require(:tipo, :capacidad).permit(:ubicacion, :descripcion))
    #@couch = Couch.create(params.require(:couches).permit(:ubicacion, :cantidad))
   # @couch.save
  #  redirect_to @couch
 #  end

  def edit
    @couch = Couch.find(params[:id])
  end

end
