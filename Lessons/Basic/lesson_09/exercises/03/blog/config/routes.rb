Rails.application.routes.draw do
  resources :posts

  # get ':year(/:month(/:day))', to: 'posts#index'
  get ':year/:month/:day', to: 'posts#index'
end
