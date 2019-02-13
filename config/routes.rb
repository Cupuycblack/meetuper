require 'resque/server'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get '/meetups', to: 'search#index'
  get '/poll', to: 'search#poll'

  mount Resque::Server.new, at: '/resque'
end
