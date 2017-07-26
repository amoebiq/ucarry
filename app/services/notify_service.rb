class NotifyService

  include UcarryConstants

  def initialize(params)

    @params = params

  end


  ############################
  ## Sender Notify Carrier ###
  ############################

  def accept_order

    carrier_id = @params[:carrier_id]
    order_id = @params[:order_id]

    @sd = SenderOrder.where(:order_id => order_id).first

    from_loc = @sd[:from_loc]
    to_loc = @sd[:to_loc]
    sender_id = @sd[:sender_id]
    @ud = User.where(:uid => sender_id).first

    @cd = User.where(:uid => carrier_id).first

    sms = SmsService.new
    msg = String.new
    msg << "Hi #{@ud[:name]}"
    msg << ",Regards from CrowdCarry team . Regarding order #{order_id},"
    msg << "#{@cd[:name]} has accepted the order to carry item(s) from"
    msg << " #{from_loc} to #{to_loc}."
    msg << " Please see your wall for more info"

    p msg
    sms.send_custom_message(@ud[:phone],msg)

    tokens = []

    tokens[0] = @ud[:dl_link]

    pns = PushNotifyService.new(@params)
    pns.send_to_specific_mobile(tokens,UcarryConstants::APP_NAME, msg )

    orch = OrchestratorService.new(nil)
    orch.update_notification(@cd[:uid],order_id,UcarryConstants::NOT_TYPE_ACCPEPT,msg,nil,nil,nil,@ud[:uid])



    msg = String.new
    msg << "Hi #{@cd[:name]}. "
    msg << ",Regards from CrowdCarry team ."
    msg << "You have accepted order #{order_id} to carry from #{from_loc} to #{to_loc}."
    msg << " Total order amount #{@params[:open_amount]}"
    sms.send_custom_message(@cd[:phone],msg)


    orch.update_notification(@ud[:uid],order_id,UcarryConstants::NOT_TYPE_ACCPEPT,msg,nil,nil,nil,@cd[:uid])



    tokens = []

    tokens[0] = @cd[:dl_link]

    pns = PushNotifyService.new(@params)
    pns.send_to_specific_mobile(tokens,UcarryConstants::APP_NAME, msg )





  end


  ############################
  ## Sender Notify Carrier ###
  ############################

  def sender_to_carrier uid
    id = @params[:schedule_id]
    sender_id = uid
    @carry_details = CarrierSchedule.where(:schedule_id => id).first
    carrier_id = @carry_details[:carrier_id]

    @carrier_details = User.where(:uid => carrier_id).first
    @sender_details = User.where(:uid => sender_id).first
    c_fname = @carrier_details[:name]
    phone = @carrier_details[:phone]
    #from_loc = @carry_details[:from_loc]
    #to_loc = @carry_details[:to_loc]
    s_fname = @sender_details[:name]
    #s_lname = @sender_details[:last_name]
    sms = SmsService.new
    msg = String.new
    msg << "Hi #{c_fname}"
    msg << ',Regards from CrowdCarry team '
    msg << "#{s_fname}  has requested to carry his item "
    #msg << "#{from_loc} to #{to_loc}."
    msg << " Please see your wall for more info"
    sms.send_custom_message(phone,msg)

    tokens = []

    tokens[0] = @carrier_details[:dl_link]

    pns = PushNotifyService.new(@params)
    pns.send_to_specific_mobile(tokens,UcarryConstants::APP_NAME, msg )

    order_id = @params[:order_id]

    orch = OrchestratorService.new(nil)
    orch.update_notification(@sender_details[:uid],id,UcarryConstants::NOT_TYPE_NOTIFY,msg,order_id,nil,nil,@carrier_details[:uid])



    resp = {}

    resp['message'] = 'Notified the carrier . Please sit back and relax while he responds'

    return resp , 200

  end



  ############################
  ## schedule created ###
  ############################

  def schedule_created

    carrier_id = @params[:carrier_id]
    @user =  User.where(:uid => carrier_id).first
    phone = @user[:phone]
    from_loc = @params[:from_loc]
    to_loc = @params[:to_loc]
    sms = SmsService.new
    msg = String.new
    msg << "Hi #{@user[:name]}"
    msg << ',Regards from CrowdCarry team '
    msg << "you have successfully created a schedule"
    msg << " #{from_loc} to #{to_loc}."
    msg << " Please see your wall for more info"
    sms.send_custom_message(phone,msg)

    tokens = []

    tokens[0] = @user[:dl_link]


    pns = PushNotifyService.new(@params)


    resp = pns.send_to_specific_mobile(tokens,UcarryConstants::APP_NAME, msg )

    orch = OrchestratorService.new(nil)
    orch.update_notification(@user[:uid],@params[:schedule_id],UcarryConstants::NOT_TYPE_SCHEDULE_CREATED,msg,nil,nil,nil,@user[:uid])


    p resp

    return

  end

  def sender_order_created
    p 'in sender order creation noficartion'
    uid = @params[:sender_id]
    @user =  User.where(:uid => uid).first
    phone = @user[:phone]
    from_loc = @params[:from_loc]
    to_loc = @params[:to_loc]
    sms = SmsService.new
    msg = String.new
    msg << "Hi #{@user[:name]}"
    msg << ',Regards from CrowdCarry team '
    msg << "you have successfully created a request to send an item"
    msg << " #{from_loc} to #{to_loc}."
    msg << " Please see your wall for more info"
    sms.send_custom_message(phone,msg)

    tokens = []

    tokens[0] = @user[:dl_link]

    p 'in sender order creation push notification'
    pns = PushNotifyService.new(@params)


    resp = pns.send_to_specific_mobile(tokens,UcarryConstants::APP_NAME, msg )

    orch = OrchestratorService.new(nil)
    orch.update_notification(@user[:uid],@params[:order_id],UcarryConstants::NOT_TYPE_ORDER_CREATED,msg,nil,nil,nil,@user[:uid])


    p resp

  end

  def build_message msg

  end




end