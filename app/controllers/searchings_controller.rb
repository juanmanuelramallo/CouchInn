class SearchingsController < ApplicationController
before_action :get_search, only: [:show]

  def index
    @searchings = Searching.where('user_id = ?', current_user.id)
  end

  def new
    @search = Searching.new
  end

  def show

    #@couches = Couch.where('tipo = ? AND ubicacion LIKE ?',
    #  @search.tipo ,'%'+@search.ubicacion_cont+'%').joins(:user).order('rol desc', 'created_at desc')

    if !@search.ubicacion_cont.blank?
      u = @search.ubicacion_cont.downcase
    else
      u = ""
    end

    if !@search.capacidad.blank?
      c = @search.capacidad
    else
      c = 0
    end

    if @search.free_from.blank?
      if !@search.tipo.blank?
        t = @search.tipo
        @couches = Couch.where(["tipo = ? and ubicacion LIKE ? AND capacidad >= ?", t ,'%'+u+'%',c ]).joins(:user).paginate(page: params[:page], per_page: 10).order('rol desc', 'created_at desc')
      else
        @couches = Couch.where(["ubicacion LIKE ? AND capacidad >= ?", '%'+u+'%',c ]).joins(:user).paginate(page: params[:page], per_page: 10).order('rol desc', 'created_at desc')
      end

    else

      rr = Reservation.all
      cocuhesOcup = []

      rr.each do |r|
        rangeRes = r.start_date..r.end_date
        rangeSearch = @search.free_from..@search.free_to
        if rangeRes.overlaps?(rangeSearch) & r.confirmed
          cocuhesOcup << r.couch_id
        end
      end

      couchesDisp = Couch.where.not(:id => cocuhesOcup)


      if !@search.tipo.blank?
        t = @search.tipo
        @couches = couchesDisp.where(["tipo = ? and ubicacion LIKE ? AND capacidad > ?", t ,'%'+u+'%',c ]).joins(:user).paginate(page: params[:page], per_page: 10).order('rol desc', 'created_at desc')
      else
        @couches = couchesDisp.where(["ubicacion LIKE ? AND capacidad > ?", '%'+u+'%',c ]).joins(:user).paginate(page: params[:page], per_page: 10).order('rol desc', 'created_at desc')
      end


    end

    #@couches = Couch.where('tipo = ? AND ubicacion LIKE ? AND capacidad = ?', @search.tipo ,'%'+u+'%',c).joins(:user).order('rol desc', 'created_at desc')

  end

  def create
    if params[:searching].nil?
      redirect_to new_searching_path, alert: 'Debes ingresar al menos un parámetro'

    elsif ( !(params[:searching][:free_from].nil?) and params[:searching][:free_to].blank? ) or (params[:searching][:free_from].blank? and !(params[:searching][:free_to].nil?))
      redirect_to new_searching_path, alert: 'Debes ingresar las dos fechas'

    else

      @search = Searching.new(params.require(:searching).permit(:tipo, :ubicacion_cont, :capacidad, :free_from, :free_to, :user_id))

      @search.user_id = current_user.id

      respond_to do |format|
        if @search.save
          format.html { redirect_to @search, notice: 'Mostrando resultados de tu búsqueda' }
          format.json { render :show, status: :created, location: @search }
        else
          format.html { render :new }
          format.json { render json: @search.errors, status: :unprocessable_entity }
        end
      end

    end
  end

private
  def get_search
    @search = Searching.find(params[:id])
  end

end
