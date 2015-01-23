class DosedIngredientsController < ApplicationController
  before_action :set_dosed_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /dosed_ingredients
  # GET /dosed_ingredients.json
  def index
    @dosed_ingredients = DosedIngredient.all
  end

  # GET /dosed_ingredients/1
  # GET /dosed_ingredients/1.json
  def show
  end

  # GET /dosed_ingredients/new
  def new
    @meal = Meal.find(params[:meal_id])
    @dosed_ingredient = DosedIngredient.new
  end

  # GET /dosed_ingredients/1/edit
  def edit
  end

  # POST /dosed_ingredients
  # POST /dosed_ingredients.json
  def create
    @dosed_ingredient = DosedIngredient.new(dosed_ingredient_params)

    puts "**** dosed_ingredient : #{dosed_ingredient_params}"
    respond_to do |format|
      if @dosed_ingredient.save
        format.html { redirect_to @dosed_ingredient.meal, notice: 'Dosed ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @dosed_ingredient }
      else
        format.html { render :new }
        format.json { render json: @dosed_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dosed_ingredients/1
  # PATCH/PUT /dosed_ingredients/1.json
  def update
    respond_to do |format|
      if @dosed_ingredient.update(dosed_ingredient_params)
        format.html { redirect_to @dosed_ingredient, notice: 'Dosed ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @dosed_ingredient }
      else
        format.html { render :edit }
        format.json { render json: @dosed_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dosed_ingredients/1
  # DELETE /dosed_ingredients/1.json
  def destroy
    @dosed_ingredient.destroy
    respond_to do |format|
      format.html { redirect_to dosed_ingredients_url, notice: 'Dosed ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dosed_ingredient
      @dosed_ingredient = DosedIngredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dosed_ingredient_params
      params.require(:dosed_ingredient).permit(:quantity, :name, :calories, :carbs, :proteins, :fat, :meal_id)
    end
end
