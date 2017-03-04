class GenericController < ApplicationController

  skip_before_action :authenticate_user!, except: [:create]

  protect_from_forgery :with=> :null_session, :if=> Proc.new { |c| c.request.format == 'application/json' }
  include OrchestratorHelper


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

  def home

  end

end
