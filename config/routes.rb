#require 'resque/server'

Rails.application.routes.draw do

  apipie
  get 'home/index'

  # devise_scope :user do
  #   post 'sessions' => 'sessions#create', :as => 'login'
  #   delete 'sessions' => 'sessions#destroy', :as => 'logout'
  # end


  #devise_for :users
  # mount_devise_token_auth_for 'User', :at => 'auth' , :controllers => {
  #     :registrations => 'registrations' , :omniauth_callbacks => 'omniauth_callbacks' , :sessions => 'sessions'
  # }

    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

    ######### carrier crud operations ##########
    #get '/carrier/:id' , :to=> 'carrier#details'
    post '/carrier', :to=> 'carrier#new', :defaults => {:format => 'json'}
    get '/carrier/all', :to=> 'carrier#all', :defaults => {:format => 'json'}
    put '/carrier/deactivate/:id' , :to=> 'carrier#deactivate', :defaults => {:format => 'json'}


    ######## carrier schedule ##########
    get '/carrier/schedules' , :to=> 'carrier#get_all_schedule', :defaults => {:format => 'json'}
    get '/carrier/schedules/all' , :to=> 'carrier#get_all_active_schedules_of_all_users', :defaults => {:format => 'json'}
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
    get '/sender/order/:order_id' , :to=> 'sender#get_order_details', :defaults => {:format => 'json'}
    get '/sender/orders/all' , :to=> 'sender#all_orders_of_all_senders' , :defaults => {:format => 'json'}
    get '/sender/orders/accepted_transactions' ,:to=> 'sender#all_orders_accepted_from_transaction' , :defaults => {:format => 'json'}


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
    post 'orchestrator/:order_id/rate_sender' , :to => 'orchestrator#rate_sender', :defaults => {:format => 'json'}
    post 'orchestrator/:order_id/rate_carrier' , :to => 'orchestrator#rate_carrier', :defaults => {:format => 'json'}

    put 'orchestrator/image' , :to => 'orchestrator#upload_image', :defaults => {:format => 'json'}

    put 'orchestrator/order/:order_id/complete' , :to => 'orchestrator#complete', :defaults => {:format => 'json'}
    put 'orchestrator/order/:order_id/in_progress' , :to => 'orchestrator#in_progress', :defaults => {:format => 'json'}
    put 'orchestrator/user/update' , :to => 'orchestrator#update_user_details', :defaults => {:format => 'json'}
    get 'orchestrator/user/detail' , :to => 'orchestrator#get_user_detail', :defaults => {:format => 'json'}

    get 'orchestrator/notifications' , :to => 'orchestrator#get_notifications_to_a_user', :defaults => {:format => 'json'}

    post 'orchestrator/subscription' , :to => 'generic#create_subscription', :defaults => {:format => 'json'}

    put 'orchestrator/order/update' , :to => 'orchestrator#update_order_status', :defaults => {:format => 'json'}

    post 'orchestrator/order/verify_completion' , :to => 'orchestrator#verify_completion_pin', :defaults => {:format => 'json'}

    post 'orchestrator/customer_support' , :to => 'orchestrator#create_issue', :defaults => {:format => 'json'}

    post 'orchestrator/payments' , :to => 'orchestrator#get_insta_payments' , :defaults => {:format => 'json' }

    get 'orchestrator/sender/orders' , :to => 'orchestrator#get_orders_of_user' , :defaults => {:format => 'json' }



    ##################################### reciever ##########################

    post 'sender/:sender_id/order/:order_id/reciever' , :to=> 'sender#update_reciever_details', :defaults => {:format => 'json'}
    put 'sender/:sender_id/order/:order_id/reciever/:id' , :to=> 'sender#edit_reciever_details', :defaults => {:format => 'json'}


    ############################## generic #################################

    put 'generic/volumetric' , :to=> 'admin#update_volumetric', :defaults => {:format => 'json'}
    get 'generic/volumetric' , :to=> 'admin#get_volumetric_data', :defaults => {:format => 'json'}


    ############################## push notification #################################

    post 'orchestrator/fcm/send/:client_id' , :to=> 'orchestrator#send_fcm_pn' , :defaults => {:format => 'json'}

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

  post 'auth/update_fcm' , :to => 'generic#update_fcm_of_user' , :defaults => {:format => 'json'}

  get 'auth/mobile/login' , :to => 'generic#check_mobile_login' , :defaults => {:format => 'json'}



  #################### notify service ##############################

  post 'orchestrator/notify_carrier/:schedule_id/order/:order_id' , :to => 'orchestrator#notify_carrier', :defaults => {:format => 'json'}

  #devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}


  ##################   views ##############################

  get 'user/home' , :to => 'generic#home'



end
