class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.find_by(public: true)
  end
end
