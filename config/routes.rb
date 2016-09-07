require 'resque/server'

Rails.application.routes.draw do

    ######### carrier crud operations ##########
    get '/carrier/:id' , :to=> 'carrier#details'
    post '/carrier', :to=> 'carrier#new'
    get '/carrier/all', :to=> 'carrier#all'
    put '/carrier/deactivate/:id' , :to=> 'carrier#deactivate'


    ######## carrier schedule ##########
    get '/carrier/:id/schedules' , :to=> 'carrier#get_all_schedule'
    post '/carrier/:id/schedule' , :to=> 'carrier#create_carrier_schedule'
    put '/carrier/:id/schedule/:schedule_id/cancel' , :to=> 'carrier#cancel_carrier_schedule'



    ######### sender crud operations ###########
    get '/sender/:id' , :to=> 'sender#details'
    post '/sender', :to=> 'sender#new'
    get '/sender/all', :to=> 'sender#all'


    ######### order ########################
    post '/sender/:id/order' , :to=> 'sender#new_order'
    get '/sender/:id/orders' , :to=> 'sender#all_orders'


   ######### schedule #########################

   get '/schedules/place' , :to=> 'schedule#to_location'


    #################### orchestrator ##################

    post '/orchestrator/coupon' , :to=> 'orchestrator#new_coupon'
    get '/orchestrator/coupon/:code' , :to=> 'orchestrator#get_coupon_details'
    put '/orchestrator/coupon/:code/deactivate' , :to=> 'orchestrator#deactivate'
    get '/orchestrator/coupons' , :to=> 'orchestrator#get_all_coupons'
    get '/orchestrator/volumetric_weight' , :to=> 'orchestrator#volumetric_weight'
    post 'orchestrator/quote' , :to=>  'orchestrator#get_quote'
    get 'orchestrator/schedules' , :to=> 'orchestrator#get_all_schedules'
    get 'orchestrator/orders' , :to=> 'orchestrator#get_all_orders'
    put 'orchestrator/carrier/:carrier_id/order/:order_id/accept' , :to => 'orchestrator#accept_order'
    

    ##################################### reciever ##########################

    post 'sender/:sender_id/order/:order_id/reciever' , :to=> 'sender#update_reciever_details'
    put 'sender/:sender_id/order/:order_id/reciever/:id' , :to=> 'sender#edit_reciever_details'


    ############################## generic #################################

    put 'generic/volumetric' , :to=> 'admin#update_volumetric'
    get 'generic/volumetric' , :to=> 'admin#get_volumetric_data'

  ########## resqueue #############
    mount Resque::Server.new, :at => "/resque"

end
