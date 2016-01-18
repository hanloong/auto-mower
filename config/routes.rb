Rails.application.routes.draw do
  resources :lawn, except: [:index, :edit, :new] do
    resources :mower, except: [:edit, :new]
    post :execute, on: :member, as: :execute
  end
end
