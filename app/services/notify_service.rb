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
    msg << "Hi #{@ud[:uid]}"
    msg << ",Regards from karrierbay.com . Regarding order #{order_id},"
    msg << "#{@cd[:uid]} has accepted the order to carry item(s) from"
    msg << " #{from_loc} to #{to_loc}."
    msg << " Please see your wall for more info"

    p msg
    sms.send_custom_message(@ud[:phone],msg)


    msg = String.new
    msg << "Hi #{@cd[:uid]}. "
    msg << ",Regards from karrierbay.com ."
    msg << "You have accepted order #{order_id} to carry from #{from_loc} to #{to_loc}."
    msg << " Total order amount #{@params[:open_amount]}"
    sms.send_custom_message(@cd[:phone],msg)






  end


  ############################
  ## Sender Notify Carrier ###
  ############################

  def sender_to_carrier uid
    id = @params[:schedule_id]
    sender_id = uid
    @carry_details = CarrierSchedule.where(:schedule_id => id).first
    carrier_id = @carry_details[:carrier_id]

    @carrier_details = CarrierDetail.where(:carrier_id => carrier_id).first
    @sender_details = SenderDetail.where(:email_id => sender_id).first
    c_fname = @carrier_details[:first_name]
    phone = @carrier_details[:phone]
    from_loc = @carry_details[:from_loc]
    to_loc = @carry_details[:to_loc]
    s_fname = @sender_details[:first_name]
    s_lname = @sender_details[:last_name]
    sms = SmsService.new
    msg = String.new
    msg << "Hi #{c_fname}"
    msg << ',Regards from karrierbay.com '
    msg << "#{s_fname} #{s_lname} has requested to carry his item from"
    msg << "#{from_loc} to #{to_loc}."
    msg << " Please see your wall for more info"
    sms.send_custom_message(phone,msg)

    tokens = []
    tokens[0] = "AAAAEW6c0PM:APA91bEW6LQLfXfyQPP8cv9o0D9-1Z_i0pUh0xsBTb0S84CDquzA_VEw9DLl9yeK5LxNk1gpcuDjhFRFrx55TiLMxwI4ktyXPUSdCsZ22XS3e_Qfmf-wCPUQBeJbv3vYIy7_Gk5E9zFF"

    pns = PushNotifyService.new(@params)
    pns.send_to_specific_mobile(tokens,UcarryConstants::APP_NAME, msg )

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
    msg << ',Regards from karrierbay.com '
    msg << "you have successfully created a schedule"
    msg << " #{from_loc} to #{to_loc}."
    msg << " Please see your wall for more info"
    sms.send_custom_message(phone,msg)

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
    msg << ',Regards from karrierbay.com '
    msg << "you have successfully created a request to send an item"
    msg << " #{from_loc} to #{to_loc}."
    msg << " Please see your wall for more info"
    sms.send_custom_message(phone,msg)

    tokens = []
    tokens[0] = "cLToQyv9oPM:APA91bGKvBp6hhzJinSxR0hHqJ8AeRGLPS2ZhfG0HXaCzC5y53Ps2nH8Tl99REIIKtAKRUdps8qMPgHkRegQVH0-fUMo4DyF52V6Gsukh4EUA3O0SLxc1eTG4o8zBw5NfWR_r8EkDYlB"

    p 'in sender order creation push notification'
    pns = PushNotifyService.new(@params)
    resp = pns.send_to_specific_mobile(tokens,UcarryConstants::APP_NAME, msg )

    p resp

  end

  def build_message msg

  end




end