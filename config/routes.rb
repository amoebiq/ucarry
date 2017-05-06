#require 'resque/server'

Rails.application.routes.draw do

  apipie
  get 'home/index'

  # devise_scope :user do
  #   post 'sessions' => 'sessions#create', :as => 'login'
  #   delete 'sessions' => 'sessions#destroy', :as => 'logout'
  # end


  #devise_for :users
  mount_devise_token_auth_for 'User', :at => 'auth' , :controllers => {
      :registrations => 'registrations' , :omniauth_callbacks => 'omniauth_callbacks' , :sessions => 'sessions'
  }

    ######### carrier crud operations ##########
    #get '/carrier/:id' , :to=> 'carrier#details'
    post '/carrier', :to=> 'carrier#new', :defaults => {:format => 'json'}
    get '/carrier/all', :to=> 'carrier#all', :defaults => {:format => 'json'}
    put '/carrier/deactivate/:id' , :to=> 'carrier#deactivate', :defaults => {:format => 'json'}


    ######## carrier schedule ##########
    get '/carrier/schedules' , :to=> 'carrier#get_all_schedule', :defaults => {:format => 'json'}
    post '/carrier/schedule' , :to=> 'carrier#create_carrier_schedule', :defaults => {:format => 'json'}
    put '/carrier/schedule/:schedule_id/cancel' , :to=> 'carrier#cancel_carrier_schedule', :defaults => {:format => 'json'}



    ######### sender crud operations ###########
    #get '/sender/:id' , :to=> 'sender#details'
    post '/sender', :to=> 'sender#new', :defaults => {:format => 'json'}
    get '/sender/all', :to=> 'sender#all', :defaults => {:format => 'json'}


    ######### order ########################
    post '/sender/order' , :to=> 'sender#new_order', :defaults => {:format => 'json'}
    put 'sender/order/:order_id/cancel' , :to => 'sender#cancel_order', :defaults => {:format => 'json'}
    get '/sender/orders' , :to=> 'sender#all_orders', :defaults => {:format => 'json'}


   ######### schedule #########################

   get '/schedules/place' , :to=> 'schedule#to_location', :defaults => {:format => 'json'}


    #################### orchestrator ##################

    post '/orchestrator/coupon' , :to=> 'orchestrator#new_coupon', :defaults => {:format => 'json'}
    get '/orchestrator/coupon/:code' , :to=> 'orchestrator#get_coupon_details', :defaults => {:format => 'json'}
    put '/orchestrator/coupon/:code/deactivate' , :to=> 'orchestrator#deactivate', :defaults => {:format => 'json'}
    get '/orchestrator/coupons' , :to=> 'orchestrator#get_all_coupons', :defaults => {:format => 'json'}
    get '/orchestrator/volumetric_weight' , :to=> 'orchestrator#volumetric_weight', :defaults => {:format => 'json'}
    post 'orchestrator/quote' , :to=>  'orchestrator#get_quote', :defaults => {:format => 'json'}
    get 'orchestrator/schedules' , :to=> 'orchestrator#get_all_schedules', :defaults => {:format => 'json'}
    get 'orchestrator/orders' , :to=> 'orchestrator#get_all_orders', :defaults => {:format => 'json'}
    put 'orchestrator/order/:order_id/accept' , :to => 'orchestrator#accept_order', :defaults => {:format => 'json'}
    post 'orchestrator/carrier/:carrier_id/order/:order_id/rate_sender' , :to => 'orchestrator#rate_sender', :defaults => {:format => 'json'}
    post 'orchestrator/sender/:sender_id/order/:order_id/rate_carrier' , :to => 'orchestrator#rate_carrier', :defaults => {:format => 'json'}

    put 'orchestrator/image' , :to => 'orchestrator#upload_image', :defaults => {:format => 'json'}
    ##################################### reciever ##########################

    post 'sender/:sender_id/order/:order_id/reciever' , :to=> 'sender#update_reciever_details', :defaults => {:format => 'json'}
    put 'sender/:sender_id/order/:order_id/reciever/:id' , :to=> 'sender#edit_reciever_details', :defaults => {:format => 'json'}


    ############################## generic #################################

    put 'generic/volumetric' , :to=> 'admin#update_volumetric', :defaults => {:format => 'json'}
    get 'generic/volumetric' , :to=> 'admin#get_volumetric_data', :defaults => {:format => 'json'}


    ############### homdse #############################################


      root 'home#index'

  ########## resqueue #############
    #mount Resque::Server.new, :at => "/resque"


  %w( 404 422 500 503 ).each do |code|
    get code, :to => 'errors#show', :code => code
  end

  get '/orders' , :to => 'view#orders', :defaults => {:format => 'json'}
  get '/register' , :to => 'view#register', :defaults => {:format => 'json'}


  #get 'users/verify', :to => 'users#show_verify', :as => 'verify'
  post 'auth/send_otp/:phone_number' , :to => 'generic#send_otp' , :defaults => {:format => 'json'}

  post 'auth/verify/:otp/phone_number/:phone_number' , :to => 'generic#verify_number' , :defaults => {:format => 'json'}
  post 'mobile/message' , :to => 'orchestrator#send_custom_message_to_mobile', :defaults => {:format => 'json'}



  #################### notify service ##############################

  post 'orchestrator/notify_carrier/:schedule_id' , :to => 'orchestrator#notify_carrier', :defaults => {:format => 'json'}

  #devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

end
