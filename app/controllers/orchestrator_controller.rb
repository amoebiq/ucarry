class OrchestratorController < ApplicationController


  protect_from_forgery :with=> :null_session, :if=> Proc.new { |c| c.request.format == 'application/json' }
  include OrchestratorHelper



  def new_coupon
    logger.debug "in new coupon code with params #{params}"


    begin
      respond_to do |format|


        details = OrchestratorHelper.new_coupon params
        #format.html  # index.html.erb
        format.json  { render :json => details ,:status => :created}
      end

    rescue Exception=>e

      render :json => e.message ,:status=>400
    end

  end

    def get_coupon_details
      logger.debug "in fetch for #{params}"

      begin
        respond_to do |format|


          details = OrchestratorHelper.get_coupon params[:code]
          #format.html  # index.html.erb
          format.json  { render :json => details}
        end

      rescue Exception=>e

        render :json => e.message , :status=>400
      end

    end

      def deactivate

          logger.debug "in deactivate for coupon #{params}"
          begin
              status,code = OrchestratorHelper.deactivate_coupon params[:code]
              respond_to do |format|
                format.json { render :json => status.to_json,:status => code}
              end
          rescue Exception =>e


                render :json => e.message , :status=>403



            end

      end

    def get_all_coupons

      begin
        coupons = OrchestratorHelper.get_all_coupons
        respond_to do |format|
          format.json { render :json => coupons}
        end
      rescue Exception =>e
        error = {}
        error['error'] = e.message
        render :json => error , :status=>404



      end

    end


    def volumetric_weight

      logger.debug "in get qoutes"
      logger.debug params

      begin


      orch = OrchestratorService.new(params)

      resp = orch.volumetric_weight

      respond_to do |format|

        format.json { render :json => resp , :status => 200}

      end

      rescue Exception=>e
        error = {}
        error['error'] = e.message
        render :json => error , :status => 400

      end


    end

  # Get the qoute for a particular order
  # @param length=30.125&breadth=5&height=10&weight=3.5
  # @return { "volumetric_weight": 0.3765625 }
    def get_quote

      begin

        orch = OrchestratorService.new(params)

        resp = orch.get_quote
        respond_to do |format|
          format.json {render :json => resp , :status=>200}
        end



      rescue Exception=>e
        p e
        error = {}
        error['error'] = e.message
        render :json=>error , :status=>400

      end
    end


    def get_all_schedules

      logger.debug "in get all schedules"

      begin


      orch = OrchestratorService.new(params)
      @schedules = orch.get_all_schedules

        respond_to do |format|
          format.json { render :json => @schedules , :status => 200}
        end

      rescue Exception=>e

        error = {}
        error['error'] = e.message
        render :json => error , :status =>400


      end

    end


  def get_all_orders

    logger.debug "in get all orders by orchestrator"
    begin

      orch = OrchestratorService.new(params)
      resp , code = orch.get_all_orders

      respond_to do |format|


        format.json { render :json => resp , :status => code}

      end
    rescue Exception=>e
      p e
      error = {}
      error['error'] = e.message
      render :json => error , :status => 400
    end

  end



  def accept_order

    logger.debug "in accept order"

    begin

      orch = OrchestratorService.new(params)
      resp,code = orch.accept_order
      respond_to do |format|
        format.json {render :json => resp , :status => code}
      end
    rescue Exception=>e
      p e
    error = {}
    error['error'] = e.message
      render :json => error , :status=>400
    end

  end

  # API to rate a sender
  # @param { "rating" : <rating in number[1-5]>}
  # @return { "message" : "successfully saved"}
  #

  def rate_sender
    logger.debug "in rate order"
    begin
      orch = OrchestratorService.new(params)
      resp , code = orch.rate_sender
      respond_to do |format|
        format.json {render :json => resp , :status => code}
      end
    rescue Exception=>e
      error = {}
      error['error'] = e.message
      render :json => error , :status => 400

    end
  end

  # API to rate a carrier
  # @param \{ "rating" : <rating in number[1-5]>\}
  # @return { "message" : "successfully saved"}
  #

  def rate_carrier
    logger.debug "in rate order"
    begin
      orch = OrchestratorService.new(params)
      resp , code = orch.rate_carrier       
      respond_to do |format|
        format.json {render :json => resp , :status => code}
      end
    rescue Exception=>e
      error = {}
      error['error'] = e.message
      render :json => error , :status => 400

    end
  end

  def send_otp

    logger.debug "in verify phone number"
    phone_number = params[:phone_number]

    begin

      orch = OrchestratorService.new(params)
      resp , code = orch.send_otp
      respond_to do |format|
        format.json {render :json => resp , :code => code}
      end
    rescue Exception=>e

      error = {}
      error['error'] = e.message
      render :json => error , :status =>400
    end
  end




  def verify_number



    orch = OrchestratorService.new(params)
    resp , code = orch.verify_otp
    respond_to do |format|
      format.json {render :json => resp , :status => code}
    end
  rescue Exception=>e
    error = {}
    error['error'] = e.message
    render :json => error , :status => 400

  end




  def send_custom_message_to_mobile

    logger.debug "in send_custom_message_to_mobile"
    phone_number = params[:phone_number]
    message = params[:message]
    begin




      twilio_client =   Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])

      pin = rand(0000..9999).to_s.rjust(4, "0")
      r = twilio_client.messages.create(
          to: phone_number,
          from: ENV['TWILIO_PHONE_NUMBER'],
          body: "#{message}")



      session[:otp_pin] = pin

      resp = {}
      resp['message'] = 'sent the message to the number'
      #resp['twilio'] = r
      respond_to do |format|
        format.json {render :json => resp , :status => 200}
      end
    rescue Exception=>e
      error = {}
      error['error'] = e.message
      render :json => error , :status => 400

    end

  end


  def notify_carrier

    logger.debug 'in notify sender'

    begin

      ns = NotifyService.new(params)

    resp , code = ns.sender_to_carrier

    respond_to do |format|
      format.json {render :json => resp , :status => code}
    end

    rescue Exception => e

      error = {}
      error['error'] = e.message
      render :json => error  , :status => 400

    end


  end


end
