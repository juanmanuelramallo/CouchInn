class SearchingsController < ApplicationController
before_action :get_search, only: [:show]

  def index

    @couches = Couch.all
    @tipos = Tipoc.all
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

  if !@search.tipo.blank?
    t = @search.tipo
    @couches = Couch.where(["tipo = ? and ubicacion LIKE ? AND capacidad > ?", t ,'%'+u+'%',c ]).joins(:user).order('rol desc', 'created_at desc')
  else
    @couches = Couch.where(["ubicacion LIKE ? AND capacidad > ?", '%'+u+'%',c ]).joins(:user).order('rol desc', 'created_at desc')
  end

  #@couches = Couch.where('tipo = ? AND ubicacion LIKE ? AND capacidad = ?', @search.tipo ,'%'+u+'%',c).joins(:user).order('rol desc', 'created_at desc')

  @fotos = Foto.all

  end

  def new
    @search = Searching.new
  end


  def create
    @search = Searching.new(params.permit(:tipo, :ubicacion_cont, :capacidad))

   respond_to do |format|
      if @search.save
         format.html { redirect_to @search, notice: "Mostrando resultados de búsqueda" }
         format.json { render :show, status: :created, location: @search }
      else
         format.html { render :index }
         format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def get_search
    @search = Searching.find(params[:id])
  end

end
