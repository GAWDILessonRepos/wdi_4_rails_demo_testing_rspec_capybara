Rails.application.routes.draw do
  resources :articles do
    resources :comments, only: [:index, :new, :create]
  end


end
