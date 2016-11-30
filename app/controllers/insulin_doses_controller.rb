class InsulinDosesController < ApplicationController
  before_action :set_insulin_dose, only: [:show, :edit, :update, :destroy]

  # GET /insulin_doses
  # GET /insulin_doses.json
  def index
    @insulin_doses = InsulinDose.order(application_time: :desc)
  end

  # GET /insulin_doses/1
  # GET /insulin_doses/1.json
  def show
  end

  # GET /insulin_doses/new
  def new
    @insulin_dose = InsulinDose.new(application_time: DateTime.now)
  end

  # GET /insulin_doses/1/edit
  def edit
  end

  # POST /insulin_doses
  # POST /insulin_doses.json
  def create
    @insulin_dose = InsulinDose.new(insulin_dose_params)

    respond_to do |format|
      if @insulin_dose.save
        format.html { redirect_to @insulin_dose, notice: 'Insulin dose was successfully created.' }
        format.json { render :show, status: :created, location: @insulin_dose }
      else
        format.html { render :new }
        format.json { render json: @insulin_dose.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insulin_doses/1
  # PATCH/PUT /insulin_doses/1.json
  def update
    respond_to do |format|
      if @insulin_dose.update(insulin_dose_params)
        format.html { redirect_to @insulin_dose, notice: 'Insulin dose was successfully updated.' }
        format.json { render :show, status: :ok, location: @insulin_dose }
      else
        format.html { render :edit }
        format.json { render json: @insulin_dose.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insulin_doses/1
  # DELETE /insulin_doses/1.json
  def destroy
    @insulin_dose.destroy
    respond_to do |format|
      format.html { redirect_to insulin_doses_url, notice: 'Insulin dose was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insulin_dose
      @insulin_dose = InsulinDose.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insulin_dose_params
      params.require(:insulin_dose).permit(%i(insulin_id dose_integral dose_fractional application_time))
    end
end
