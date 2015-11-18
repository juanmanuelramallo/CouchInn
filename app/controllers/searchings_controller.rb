class SearchingsController < ApplicationController
before_action :get_search, only: [:show]

  def index

    @couches = Couch.all
    @tipos = Tipoc.all
    @search = Searching.new

  end

  def show

    @couches = Couch.where('tipo = ? AND ubicacion LIKE ?',
      @search.tipo ,'%'+@search.ubicacion_cont+'%').joins(:user).order('rol desc', 'created_at desc')

    @fotos = Foto.all

  end

  def create
    @search = Searching.new(params.require(:searching).permit(:tipo, :ubicacion_cont))

   respond_to do |format|
      if @search.save
         format.html { redirect_to @search, notice: "Mostrando resultados de búsqueda" }
         format.json { render :show, status: :created, location: @search }
      else
         format.html { render :new }
         format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def get_search
    @search = Searching.find(params[:id])
  end

end
