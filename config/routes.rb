Rails.application.routes.draw do
  resources :categories
  resource :profiles, only: %i(update)
  resources :profiles, only: %i(show)
  resources :casts

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }, skip: :registrations
  devise_scope :user do
    resource :registration,
             only: %i(new create edit update),
             path: 'users',
             path_names: { new: 'sign_up' },
             controller: 'devise/registrations',
             as: :user_registration
  end

  get '/colabore', to: redirect('https://github.com/RubyCastsBrasil/RubyCastsBrasil/wiki/Contribuindo'), as: :contributing
  get '/sobre', to: redirect('https://github.com/RubyCastsBrasil/RubyCastsBrasil/wiki/Sobre-o-projeto'), as: :about

  get '/' => 'home#index', as: :users
  root to: 'home#index'
end
