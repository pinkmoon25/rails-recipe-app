class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]
    if @recipe_food.save
      flash[:notice] = 'Ingredient added successfully'
      redirect_to recipe_path(params[:recipe_id])
    else
      flash.now[:alert] = @recipe_food.errors.first.message
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @food = @recipe.foods.find(params[:id])
    @recipe_food = RecipeFood.find_by(food_id: @food.id)
    @recipe_food.destroy
    flash[:notice] = 'Ingredient removed successfully'
    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
