class BloodSugarReadingsController < ApplicationController
  before_action :set_blood_sugar_reading, only: [:show, :edit, :update, :destroy]

  # GET /blood_sugar_readings
  # GET /blood_sugar_readings.json
  def index
    @blood_sugar_readings = BloodSugarReading.order(read_time: :desc)
  end

  # GET /blood_sugar_readings/1
  # GET /blood_sugar_readings/1.json
  def show
  end

  # GET /blood_sugar_readings/new
  def new
    @blood_sugar_reading = BloodSugarReading.new(blood_sugar_reading_params)
  end

  # GET /blood_sugar_readings/1/edit
  def edit
  end

  # POST /blood_sugar_readings
  # POST /blood_sugar_readings.json
  def create
    @blood_sugar_reading = BloodSugarReading.new(blood_sugar_reading_params)

    respond_to do |format|
      if @blood_sugar_reading.save
        format.html { redirect_to @blood_sugar_reading, notice: 'Blood sugar reading was successfully created.' }
        format.json { render :show, status: :created, location: @blood_sugar_reading }
      else
        format.html { render :new }
        format.json { render json: @blood_sugar_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blood_sugar_readings/1
  # PATCH/PUT /blood_sugar_readings/1.json
  def update
    respond_to do |format|
      if @blood_sugar_reading.update(blood_sugar_reading_params)
        format.html { redirect_to @blood_sugar_reading, notice: 'Blood sugar reading was successfully updated.' }
        format.json { render :show, status: :ok, location: @blood_sugar_reading }
      else
        format.html { render :edit }
        format.json { render json: @blood_sugar_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blood_sugar_readings/1
  # DELETE /blood_sugar_readings/1.json
  def destroy
    @blood_sugar_reading.destroy
    respond_to do |format|
      format.html { redirect_to blood_sugar_readings_url, notice: 'Blood sugar reading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blood_sugar_reading
      @blood_sugar_reading = BloodSugarReading.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blood_sugar_reading_params
      params.require(:blood_sugar_reading).permit(:value, :read_time)
    end
end
