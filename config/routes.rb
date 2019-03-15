# frozen_string_literal: true

Rails.application.routes.draw do
  # RESTful routes
  resources :trades, except: %i[new edit]
  resources :examples, except: %i[new edit]

  # Custom routes
  get '/closed-trades' => 'trades#index_closed'
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out' => 'users#signout'
  patch '/change-password' => 'users#changepw'
end
