Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  root "pages#home"

  resources :owners
  resources :pets
  resources :vets
  resources :appointments do
    resources :treatments, except: [:index, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end