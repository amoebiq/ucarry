Rails.application.routes.draw do

    ######### carrier crud operations ##########
    get '/carrier/:id' , to: 'carrier#details'
    post '/carrier', to: 'carrier#new'
    get '/carrier/all', to: 'carrier#all'
    put '/carrier/deactivate/:id' , to: 'carrier#deactivate'


    ######## carrier schedule ##########
    get '/carrier/:id/schedules' , to: 'carrier#get_all_schedule'
    post '/carrier/:id/schedule' , to: 'carrier#create_carrier_schedule'
    put '/carrier/:id/schedule/:schedule_id/cancel' , to: 'carrier#cancel_carrier_schedule'



    ######### sender crud operations ###########
    get '/sender/:id' , to: 'sender#details'
    post '/sender', to: 'sender#new'
    get '/sender/all', to: 'sender#all'




end
