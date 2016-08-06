Rails.application.routes.draw do

    ######### carrier crud operations
    post '/carrier', to: 'carrier#new'
    get '/carrier/all', to: 'carrier#all'
    put '/carrier/deactivate/:id' , to: 'carrier#deactivate'


    ######### sender crud operations
    post '/sender', to: 'sender#new'
    get '/sender/all', to: 'sender#all'




end
