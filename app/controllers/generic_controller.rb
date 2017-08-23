require 'net/http'

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

  def check_google_login

    p 'in google login'
    token = params[:token]


  end

  def check_mobile_login

    p 'in mobile login'
    base_uri = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token";
    token = params[:token]
    provider = params[:provider]
    if provider.eql?"facebook"


    user = FbGraph2::User.me(token)
    user = user.fetch(fields: [:name,:email, :first_name, :last_name,:picture,:id])
    p user.picture(:large)
    p "Email is #{user.email}"
    provider = "facebook"
    orch = OrchestratorService.new(params)
    resp,code = orch.check_mobile_login(user,provider)
    end
    if provider.eql?"google"
      p 'provider is google'
      url = URI.parse(base_uri+"="+token)
      p url.to_s
      req = Net::HTTP.new(url.host,url.port)
      req.use_ssl = true

      @data = req.get(url.request_uri)

      g_user = JSON.parse(@data.body)

      p g_user
      p g_user["given_name"]

      provider = "google"
      orch = OrchestratorService.new(params)
      resp,code = orch.check_mobile_login(g_user,provider)


    end

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


  def create_subscription

    p 'in create subscription'

    orch = OrchestratorService.new(params)
    resp,code = orch.add_subscription

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
