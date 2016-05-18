class InsulinsController < ApplicationController
  before_action :set_insulin, only: [:show, :edit, :update, :destroy]

  # GET /insulins
  # GET /insulins.json
  def index
    @insulins = Insulin.all
  end

  # GET /insulins/1
  # GET /insulins/1.json
  def show
  end

  # GET /insulins/new
  def new
    @insulin = Insulin.new
  end

  # GET /insulins/1/edit
  def edit
  end

  # POST /insulins
  # POST /insulins.json
  def create
    @insulin = Insulin.new(insulin_params)

    respond_to do |format|
      if @insulin.save
        format.html { redirect_to @insulin, notice: 'Insulin was successfully created.' }
        format.json { render :show, status: :created, location: @insulin }
      else
        format.html { render :new }
        format.json { render json: @insulin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insulins/1
  # PATCH/PUT /insulins/1.json
  def update
    respond_to do |format|
      if @insulin.update(insulin_params)
        format.html { redirect_to @insulin, notice: 'Insulin was successfully updated.' }
        format.json { render :show, status: :ok, location: @insulin }
      else
        format.html { render :edit }
        format.json { render json: @insulin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insulins/1
  # DELETE /insulins/1.json
  def destroy
    @insulin.destroy
    respond_to do |format|
      format.html { redirect_to insulins_url, notice: 'Insulin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insulin
      @insulin = Insulin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insulin_params
      params.require(:insulin).permit(:name)
    end
end
