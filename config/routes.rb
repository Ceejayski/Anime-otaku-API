Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :admin do
        resources :users, only: %i[index destroy]
        patch '/make_admin/:id', to: 'users#make_admin'
        patch '/remove_admin/:id', to: 'users#remove_admin'
      end
      resources :animes, only: %i[index show]
      resources :favourites, only: %i[index create destroy]
      post 'sign_up', to: 'registrations#create'
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
      post 'login', to: 'authentication#authenticate'
    end
  end
end
