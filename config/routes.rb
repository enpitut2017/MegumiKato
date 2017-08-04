Rails.application.routes.draw do
  resources :positions do
    collection do
      get :getpos
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
