Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/sites/index', to: 'sites#index', as: 'index'

  root 'sites#index'


  post '/sites/test', to: 'sites#test', as: 'test'


end
