class TipocsController < ApplicationController
  before_action :set_tipo, only: [:show, :edit, :update, :destroy]


  def index
    @new = Tipoc.new
    @tipos = Tipoc.all
  end

  def show

  end

  def edit
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


  def update
    respond_to do |format|
      if @tipo.update(tipo_params)
        format.html { redirect_to @tipo, notice: 'Tipo fue actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @tipo }
      else
        format.html { render :edit }
        format.json { render json: @tipo.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    Tipoc.find(params[:id]).destroy
    redirect_to tipocs_path
  end

private
  def set_tipo
    @tipo = Tipoc.find(params[:id])
  end

  def tipo_params
    params.require(:tipoc).permit(:tipo)
  end

end
