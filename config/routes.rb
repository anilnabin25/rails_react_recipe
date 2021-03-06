Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # get 'recipes/index'
      # post 'recipes/create'
      # get 'recipes/show/:id', to: 'recipes#show'
      # delete 'recipes/destroy/:id', to: 'recipes#destroy'
      resources :recipes, only: %i[index show create destroy]
    end
  end
  root 'homepage#index'
  get '/*path' => 'homepage#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
