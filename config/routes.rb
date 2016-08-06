Rails.application.routes.draw do

    ######### carrier crud operations
    post '/carrier', to: 'carrier#new'
    get '/carrier/all', to: 'carrier#all'


end
