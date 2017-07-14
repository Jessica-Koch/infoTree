Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

    resources :wikis
  resources :charges, only: [:new, :create]
  get 'thanks', to: 'charges#thanks', as: 'thanks'
  root 'home#index'

end
