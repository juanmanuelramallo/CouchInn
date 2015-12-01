class CouchesController < ApplicationController

  before_action :get_couch, only:[:edit, :update, :destroy, :is_owner?]
  before_action :get_types, only:[:edit, :update, :show, :new]

  #attr_accessible :ubicacion, :descripcion, :tipo, :capacidad


  def main
    @couches = Couch.joins(:user).where('eliminado = ?', false).paginate(page: params[:page], per_page: 15).order('rol desc', 'created_at desc')
  end

  def index
    @couches = Couch.joins(:user).where('user_id = ?', current_user.id).paginate(page: params[:page], per_page: 15).order('rol desc', 'created_at desc')

    @couches.each do |c|
        if Reservation.where('couch_id = ? and confirmed = ?', c.id, true).count == 0
          if c.eliminado == true
            c.destroy
          end
        end
    end
  end

  def show
    @couch = Couch.find(params[:id])
    @nuevacalif = Qualification.new
    @questions = Question.where('couch_id = ?', @couch.id)
    @question = Question.new
  end


  def new
    @couch = Couch.new
  end

  #protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:new) << :ubicacion
  end

  def create
  @couch = Couch.new(params.require(:couch).permit(:user_id, :tipo,:ubicacion, :descripcion, :capacidad, :photo))
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


  def destroy
    #si no tiene reservas confirmadas este couch lo elimino
    if Reservation.where('couch_id = ? and confirmed = ?', @couch.id, true).count == 0
      @couch.destroy
      flash[:notice] = 'El Couch ha sido eliminado exitosamente'
    else
      @couch.eliminado = true
      @couch.save
      flash[:notice] = 'El Couch ya no se encuentra visible. Cuando las reservas actuales se completen será eliminado de forma definitiva'
    end

      redirect_to couches_path
  end

  private

  def get_couch
    @couch = Couch.find(params[:id])
  end

  def get_types
    @tipos = Tipoc.pluck(:tipo)
  end

  def get_id
    @c_id = Couch.id
  end


  def couch_params
    params.require(:couch).permit(:tipo, :ubicacion, :descripcion, :capacidad, :photo)
  end

end
