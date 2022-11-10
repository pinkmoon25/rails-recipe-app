class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @food_list = []
    @total = 0
    flag = true
    current_user.recipes.includes([:foods]).each do |recipe|
      recipe.foods.each do |food|
        q = RecipeFood.find_by(food_id: food.id).quantity
        f = current_user.foods.find(food.id)
        flag = check_duplicate(@food_list, f, q)
        if (f.quantity - q).negative? && flag
          @food_list << { name: f.name, quantity: f.quantity - q, price: f.price * (f.quantity - q) }
        end
      end
    end
    @food_list.each { |f| @total += f[:price] }
    @food_list
  end

  def check_duplicate(food_list, food, quantity)
    food_list.each do |food_item|
      next unless food_item[:name] == food.name

      food_item[:quantity] = food_item[:quantity] - quantity
      food_item[:price] = food_item[:quantity] * food.price
      return false
    end
  end
end
