Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # /parties routes
  get '/parties', to: 'parties#index'
  get '/parties/new', to: 'parties#new'
  get '/parties/:id', to: 'parties#show'
  get '/parties/:id/adventurers', to: 'parties#adventurers'
  post '/parties', to: 'parties#create'
  
  # /adventurers routes
  get '/adventurers', to: 'adventurers#index'
  get '/adventurers/:id', to: 'adventurers#show'
end
