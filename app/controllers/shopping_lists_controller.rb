class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @food_list = []
    current_user.recipes.each do |recipe|
      recipe.foods.each do |food|
        q = RecipeFood.find_by(food_id: food.id).quantity
        f = current_user.foods.find(food.id)
        if (f.quantity - q).negative?
          @food_list << { name: f.name, quantity: f.quantity - q, price: f.price * (f.quantity - q) }
        end
      end
    end
    @food_list
  end
end
