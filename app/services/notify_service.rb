class NotifyService

  def initialize(params)

    @params = params

  end


  ############################
  ## Sender Notify Carrier ###
  ############################

  def sender_to_carrier
    id = @params[:schedule_id]
    sender_id = @params[:sender_id]
    @carry_details = CarrierSchedule.where(:schedule_id => id).first
    carrier_id = @carry_details[:carrier_id]

    @carrier_details = CarrierDetail.where(:carrier_id => carrier_id).first
    @sender_details = SenderDetail.where(:sender_id => sender_id).first
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

    resp = {}

    resp['message'] = 'Notified the carrier . Please sit back and relax while he responds'

    return resp , 200

  end


  ############################
  ## Sender Notify Carrier ###
  ############################

  def sender_to_carrier
    id = @params[:schedule_id]
    sender_id = @params[:sender_id]
    @carry_details = CarrierSchedule.where(:schedule_id => id).first
    carrier_id = @carry_details[:carrier_id]

    @carrier_details = CarrierDetail.where(:carrier_id => carrier_id).first
    @sender_details = SenderDetail.where(:sender_id => sender_id).first
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


  end

  def build_message msg

  end




end