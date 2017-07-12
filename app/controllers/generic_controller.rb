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


  def update_fcm_of_user

    uid = request.headers['Uid']
    reg_id = params['reg_id']

    orch = OrchestratorService.new(params)
    resp , code = orch.update_fcm_details(uid,reg_id)
    respond_to do |format|
      format.json {render :json => resp , :status => code}
    end

  rescue Exception=>e

    error = {}
    error['error'] = e.message
    render :json => error , :status => 400

  end

  def check_mobile_login

    p 'in mobile login'
    token = params[:token]
    user = FbGraph2::User.me(token)
    user = user.fetch(fields: [:name,:email, :first_name, :last_name,:picture,:id])
    p user.picture(:large)
    p "Email is #{user.email}"
    orch = OrchestratorService.new(params)
    resp,code = orch.check_mobile_login(user)

    map = {}
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => resp,:status =>code }
    end

  rescue Exception=>e
    p e.message
    error = {}
    error['error'] = e.message

    p error
    render :json => error , :status => 400

  end

end
