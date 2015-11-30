class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  def resumen
  end

  def main

    if !params[:from].blank? and !params[:to].blank?
      if Date.parse(params[:from]) < Date.parse(params[:to])
        @payments = Payment.search(params[:from], params[:to]).order("created_at DESC")
        @sum = 0
      else
        redirect_to payments_resumen_path, alert:"Fecha de inicio debe ser anterior a fecha de fin"
      end
    else
      redirect_to payments_resumen_path, alert: "Debes ingresar las fechas para crear el resumen"
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create

    @payment = Payment.new(params.require(:payment).permit(:amount ,:cardNumber, :cardCVV, :cardExpiryMonth, :cardExpiryYear))
    @payment.user_id = current_user.id

    respond_to do |format|
      if @payment.save

        if current_user.rol == "normal"
          current_user.premium!
          format.html { redirect_to root_path, notice: 'El pago fue concretado correctamente. Ahora sos premium!' }
          format.json { render :index, status: :created, location: @payment }
        elsif current_user.rol == "admin"
          format.html { redirect_to root_path, alert: 'Sos admin, que más querés?' }
        else
          format.html { redirect_to root_path, alert: 'Ya sos premium, no podes ser doblemente premium'}
        end

      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:amount, :responseCode, :responseMessage)
    end
end
