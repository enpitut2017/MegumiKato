Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  resources :bicycles do
    member do
      get :image
    end
  end
  resources :positions, :path => '/' 
  post '/callback' => 'linebot#callback'
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
