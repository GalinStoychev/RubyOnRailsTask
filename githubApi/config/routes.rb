Rails.application.routes.draw do
   root to: 'users#index'
  namespace :api, :default => {:format => :json} do
    get 'users', to: "users#index"
    get ':username/popular_repos', to: "users#show"
  end

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
