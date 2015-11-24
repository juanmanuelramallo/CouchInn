class QualificationsController < ApplicationController
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def index
    
  end

  def show
    @calificacion = Qualification.where(couch_id: params[:couch_id])
  end

  def new
    @nuevacalif = Qualification.new(couch_id: params[:couch_id])
  end

  def create
    @nuevacalif = Qualification.new(params.require(:qualification).permit(:couch_id, :user_id, :percentage))
    @nuevacalif.user_id = current_user.id
    @nuevacalif.save
    respond_to do |format|
      if @nuevacalif.save
        format.html {redirect_to Couch.find(@nuevacalif.couch_id), notice:"Has calificado correctamente."}
        format.json {render :show, status: :created, location: Couch.find(@nuevacalif.couch_id)}
      else
        format.html {render :new }
        format.json {render json: Couch.find(@nuevacalif.couch_id).errors, status: :unprocessable_entity }       
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
