class QualificationsController < ApplicationController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def index
    @miscalif = Qualification.where(user_id: current_user)
  end

  def show
    @calificacion = Qualification.where(couch_id: params[:couch_id])
  end

  def new
    @nuevacalif = Qualification.new(couch_id: params[:couch_id])
  end

  def create
    @nuevacalif = Qualification.new(params.require(:qualification).permit(:couch_id, :user_id, :percentage, :description))
    @nuevacalif.user_id = current_user.id

    respond_to do |format|
      if @nuevacalif.save

        Message.create(user_id: Couch.get_owner(@nuevacalif.couch_id),
          message:"El couch #{@nuevacalif.couch_id} ha recibido una nueva calificación",
          object:"qualification",
          link:"/qualifications/show?couch_id=#{@nuevacalif.couch_id}"
          )

        format.html {redirect_to Couch.find(@nuevacalif.couch_id), notice:"Tu calificación fue enviada correctamente."}
      else
        format.html {redirect_to Couch.find(@nuevacalif.couch_id), alert: "Solo puedes calificar una vez por cada visita al couch"}
      end
    end
  end

  def update
    @nuevacalif = Qualification.where(couch_id: params[:couch_id])
  end

  def destroy
  end

  def edit
    @calif = Qualification.find(params[:qualifications_id])
  end
end
