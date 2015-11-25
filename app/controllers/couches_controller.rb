class CouchesController < ApplicationController

  before_action :get_couch, only:[:edit, :update, :destroy, :show, :is_owner?]
  before_action :get_types, only:[:edit, :update, :show, :new]

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

  def main
    @couches = Couch.joins(:user).where('eliminado = ?', false).order('rol desc', 'created_at desc')
    @fotos = Foto.all
  end

  def index
    @couches = Couch.joins(:user).order('rol desc', 'created_at desc').where('user_id = ?', current_user.id)

    @couches.each do |c|
        if Reservation.where('couch_id = ? and confirmed = ?', c.id, true).count == 0
          if c.eliminado == true
            c.destroy
          end
        end
    end

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
   respond_to do |format|
      if @couch.update(couch_params)
         format.html { redirect_to @couch, notice: "El couch fue modificado correctamente." }
         format.json { render :show, status: :ok, location: @couch }
      else
         format.html { render :edit }
         format.json { render json: @couch.errors, status: :unprocessable_entity }
      end
    end
end

def edit

end

 def couch_params
    params.require(:couch).permit(:usuario_id, :tipo,:ubicacion, :descripcion, :capacidad)
  end

def destroy

  if Reservation.where('couch_id = ? and confirmed = ?', @couch.id, true).count == 0
  
    flash[:notice] = 'El Couch ha sido eliminado exitosamente'
  else
    @couch.eliminado = true
    @couch.save
    flash[:notice] = 'El Couch ya no se encuentra visible. Cuando las reservas actuales se completen será eliminado de forma definitiva'
  end

    redirect_to couches_path
end

end
