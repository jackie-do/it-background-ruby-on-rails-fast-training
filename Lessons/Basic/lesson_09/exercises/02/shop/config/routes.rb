Rails.application.routes.draw do
  get 'home/index'
  get 'home/ping'
  # get 'home/pong'

  # Using option "as"
  get 'home/pong', as: 'different_name'
  # Using option "to"
  get 'home/applepie', to: 'home#ping'

end
