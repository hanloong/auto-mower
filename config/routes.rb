Rails.application.routes.draw do
  resources :lawn, except: [:index, :edit, :new] do
    resources :mower, except: [:index, :edit, :new]
    post :execute
  end
end
