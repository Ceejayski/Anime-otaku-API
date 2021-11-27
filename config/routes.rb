Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :admin do
        resources :users, only: %i[index destroy]
        resources :animes, only: %i[index create update destroy]
        patch '/make_admin/:id', to: 'users#make_admin'
        patch '/remove_admin/:id', to: 'users#remove_admin'
      end
      resources :animes, only: %i[index show] do
        resources :favourites, only: %i[index create destroy]
      end
      resources :users, only: %i[show] do
        get '/favourite', to: 'user_favourites#index'
        delete '/remove_favorite/:id', to: 'user_favourites#destroy'
      end
      post 'sign_up', to: 'registrations#create'
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
      post 'login', to: 'authentication#authenticate'
    end
  end
end
