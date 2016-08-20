Rails.application.routes.draw do

    ######### carrier crud operations ##########
    post '/carrier', to: 'carrier#new'
    get '/carrier/all', to: 'carrier#all'
    put '/carrier/deactivate/:id' , to: 'carrier#deactivate'


    ######## carrier schedule ##########
    post '/carrier/:id/schedule' , to: 'carrier#create_carrier_schedule'
    put '/carrier/:id/schedule/:schedule_id/cancel' , to: 'carrier#cancel_carrier_schedule'



    ######### sender crud operations ###########
    post '/sender', to: 'sender#new'
    get '/sender/all', to: 'sender#all'




end
