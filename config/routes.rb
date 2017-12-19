Rails.application.routes.draw do
  root to: 'top_page#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  resources :positions 
  post '/callback' => 'linebot#callback'
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
