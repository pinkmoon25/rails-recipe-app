class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      flash[:notice] = 'food created successfully'
      redirect_to foods_path
    else
      flash.now[:alert] = @food.errors.first.message
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:notice] = 'Food removed successfully'
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
