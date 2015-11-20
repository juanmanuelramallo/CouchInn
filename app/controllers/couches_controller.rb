class CouchesController < ApplicationController

  before_action :get_couch, only:[:edit, :update, :destroy, :show, :is_owner?]
  before_action :get_types, only:[:edit, :update, :show, :new]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  #attr_accessible :ubicacion, :descripcion, :tipo, :capacidad

  def get_couch
    @couch = Couch.find(params[:id])
  end

  def get_types
    @tipos = Tipoc.pluck(:tipo)
  end

  def get_id
    @c_id = Couch.id
  end

  def is_owner?(user)
    return @couch.user_id == user.id
  end

  def index
    @couches = Couch.joins(:user).order('rol desc', 'created_at desc')
    @fotos = Foto.all
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
  @couch = Couch.new(params.require(:couch).permit(:user_id, :tipo,:ubicacion, :descripcion, :capacidad))
  @couch.reservado = false
  @couch.user_id = current_user.id

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

def update
 @couch = Couch.find(params[:id])
 @couch.save
end

  def edit
    @couch = Couch.find(params[:id])
  end

end
