class TipocsController < ApplicationController



  def index
    @new = Tipoc.new
    @tipos = Tipoc.all
  end

  def show

  end

  def update

  end

  def new
    @tipo = Tipoc.new
  end

  def create
  @tipo = Tipoc.new(params.require(:tipoc).permit(:tipo))

   respond_to do |format|
      if @tipo.save
         format.html { redirect_to tipocs_path, notice: "El tipo fue creado correctamente." }
         format.json { render :show, status: :created, location: tipocs_path }
      else
         format.html { render :new }
         format.json { render json: @tipo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end
end
