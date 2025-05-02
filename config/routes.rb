Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  get 'public/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "public#index"

  get "klass_modal" => "klass#klass_modal"
  get "race_modal" => "race#race_modal"
  resources :characters, only: [:index, :show, :create, :update] do
    member do
      delete :remove_token
    end
    resources :characters_steps, only: [:show, :create, :update]
  end
end
