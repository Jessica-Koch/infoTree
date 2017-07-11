Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # resources :users, only: [] do
  resources :wikis
  # end


  root 'home#index'

end
