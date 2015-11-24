class ReservationsController < ApplicationController
  before_action :get_reserva, only: [:edit, :update, :confirm, :destroy]

  def index
    @couchactual = Couch.find(params[:cid])
    @reservas = Reservation.where('couch_id = ?', params[:cid])
  end

  def misreservas
    @reservas = Reservation.where('user_id = ?', current_user.id)
  end

  def show
     #@reservas = Reservation.where(couch_id: params[:couch_id])
  end


  def new

    if ( !tiene_reserva_del_couch )
      @reserva = Reservation.new(couch_id: params[:couch_id])
    else
      redirect_to Couch.find(params[:couch_id]), alert: "Ya tenés una reserva para este couch"
    end

  end


  def edit
    if @reserva.confirmed
      redirect_to reservations_misreservas_path, alert: "Tu reserva está confirmada y no se puede modificar"
    end
  end


  def create

    #validar si no tiene una reserva aceptada con otro couch (en el modelo)

    @reserva = Reservation.new(params.require(:reservation).permit(:couch_id,:confirmed, :start_date, :end_date))
    @reserva.user_id = current_user.id
    @reserva.confirmed = false

    respond_to do |format|
      if @reserva.save
        format.html { redirect_to Couch.find(@reserva.couch_id), notice: "La reserva fue creada correctamente." }
        format.json { render :show, status: :created, location:  Couch.find(@reserva.couch_id) }
      else
        format.html { render :new }
        format.json { render json: Couch.find(@reserva.couch_id).errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if @reserva.destroy
      redirect_to :back, notice: "La reserva fue eliminada correctamente"
    else
      redirect_to :back, alert: "Un error impidió que la reserva fuera eliminada"
    end
  end

  def update

    #validar si no tiene una reserva confirmada con otro couch en la misma fecha (en el modelo)

    respond_to do |format|
      if @reserva.update(params.require(:reservation).permit(:start_date, :end_date))

        format.html { redirect_to reservations_misreservas_path, notice: "La reserva fue actualizada." }
        format.json { render :misreservas, status: :created, location:  reservations_misreservas_path }

      else
        format.html { redirect_to reservations_misreservas_path, notice: "La reserva no pudo ser actualizada" }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end

  end



  def confirm

    #validar si no tiene una reserva confirmada con otro couch en la misma fecha (en el modelo)

    respond_to do |format|
      if @reserva.update(confirmed: true)
        #eliminar todas las reservas del usuario actual que coincidan con la fecha de esta reserva aceptada
        eliminar_reservas_coincidentes

        format.html { redirect_to reservations_path(cid: @reserva.couch_id), notice: "La reserva fue aceptada." }
        format.json { render :index, status: :created, location:  reservations_path(cid: @reserva.couch_id) }

      else
        format.html { redirect_to reservations_path(cid: @reserva.couch_id), notice: "La reserva ya había sido aceptada" }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end

  end



  def seleccionar
  end

private
  def get_reserva
    @reserva = Reservation.find(params[:id])
  end

  def tiene_reserva_del_couch
    r = Reservation.where('couch_id = ? and user_id = ?', params[:couch_id], current_user.id)
    if r.count == 1 #si la cantidad de reservas del usuario al couch es 1 ya tiene reserva del couch actual
      return true
    else
      return false
    end
  end


  def eliminar_reservas_coincidentes
    #todas las reservas del usuario actual sin confirmar

    r = Reservation.where('user_id = ? and confirmed = ?', @reservatrue.user_id, false)
    rango = @reservatrue.start_date..@reservatrue.end_date

    r.each do |res|
      aux = res.start_date..res.end_date
      if aux.overlaps?(rango)

        res.destroy
        flash[:notice] << "Una reserva fue eliminada debido a fechas coincidentes con la reserva aceptada recientemente"
        User.find(res.user_id).errors.add(:base, "La reserva que hiciste el dia #{res.created_at.to_formatted_s(:short)} fue eliminada debido a la aceptación de otra reserva en fechas coincidentes.")
      end
    end
  end

end
