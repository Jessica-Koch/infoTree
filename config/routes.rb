Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :wikis do
    resources :collaborators
  end
  resources :charges, only: [:new, :create]
  delete '/cancel_plan' => 'charges#cancel_plan'
  root 'home#index'

end
