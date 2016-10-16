class SmsService



  def initialize

    @TWILIO_PHONE_NUMBER = '+18573080021'
    @TWILIO_ACCOUNT_SID='ACe58312f5989c6a6d665235c2ae4a038a'
    @TWILIO_AUTH_TOKEN='43a0d0a2cee92f1a4fcc5a889cdd893c'

  end
  def send_custom_message (number , message)



    begin


      p "in sned custom message #{@TWILIO_PHONE_NUMBER}"
      p "#{number} , #{message}"
      twilio_client =   Twilio::REST::Client.new(@TWILIO_ACCOUNT_SID, @TWILIO_AUTH_TOKEN)


      r = twilio_client.messages.create(:to=>"#{number}", :from => @TWILIO_PHONE_NUMBER ,:body => "#{message}")





      resp = {}
      resp['message'] = 'sent the message to the number'
      #resp['twilio'] = r

    rescue Exception=>e
      error = {}
      error['error'] = e.message


    end

  end



end