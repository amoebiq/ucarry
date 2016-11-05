#require 'resque/server'

Rails.application.routes.draw do

  apipie
  get 'home/index'

  # devise_scope :user do
  #   post 'sessions' => 'sessions#create', :as => 'login'
  #   delete 'sessions' => 'sessions#destroy', :as => 'logout'
  # end


  #devise_for :users
  mount_devise_token_auth_for 'User', at: 'auth'

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
    put 'sender/:sender_id/order/:order_id/cancel' , :to => 'sender#cancel_order'
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
    post 'orchestrator/carrier/:carrier_id/order/:order_id/rate_sender' , :to => 'orchestrator#rate_sender'
    post 'orchestrator/sender/:sender_id/order/:order_id/rate_carrier' , :to => 'orchestrator#rate_carrier'


    ##################################### reciever ##########################

    post 'sender/:sender_id/order/:order_id/reciever' , :to=> 'sender#update_reciever_details'
    put 'sender/:sender_id/order/:order_id/reciever/:id' , :to=> 'sender#edit_reciever_details'


    ############################## generic #################################

    put 'generic/volumetric' , :to=> 'admin#update_volumetric'
    get 'generic/volumetric' , :to=> 'admin#get_volumetric_data'


    ############### homdse #############################################


      root 'home#index'

  ########## resqueue #############
    #mount Resque::Server.new, :at => "/resque"


  %w( 404 422 500 503 ).each do |code|
    get code, :to => 'errors#show', :code => code
  end

  get '/orders' , :to => 'view#orders'
  get '/register' , :to => 'view#register'


  #get 'users/verify', :to => 'users#show_verify', :as => 'verify'
  post 'auth/send_otp/:phone_number' , :to => 'orchestrator#send_otp'

  post 'auth/verify/:otp' , :to => 'orchestrator#verify_number'
  post 'mobile/message' , :to => 'orchestrator#send_custom_message_to_mobile'



  #################### notify service ##############################

  post 'orchestrator/sender/:sender_id/notify_carrier/:schedule_id' , :to => 'orchestrator#notify_carrier'

  #devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

end
