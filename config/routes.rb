Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :recipes, except: :update do
    resources :recipe_foods, except: :update
  end
  resources :foods, except: :update
  resources :public_recipes, only: :index
end
