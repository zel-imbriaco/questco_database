Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/parties', to: 'parties#index'
  get '/parties/:id', to: 'parties#show'
end
