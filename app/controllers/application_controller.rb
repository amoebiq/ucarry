class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  require_relative '../../lib/utilities/ucarry_constants'
  require_relative '../../app/models/user'

  #protect_from_forgery with: :exception

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

 # protect_from_forgery with: :null_session

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user


  before_action :print_creds

  #before_action :authenticate_user!, except: [:create]

  def print_creds
    p "in print creds"
    # extract client_id from auth header
    client_id = request.headers['client']

# update token, generate updated auth headers for response
    new_auth_header = {}
    new_auth_header['rest'] = 'testAAXX'

# update response with the header that will be required by the next request
    response.headers.merge!(new_auth_header)

  end




  # before_filter do
  #   resource = controller_name.singularize.to_sym
  #   method = "#{resource}_params"
  #   params[resource] &&= send(method) if respond_to?(method, true)
  # end
  #
  # rescue_from CanCan::AccessDenied do |exception|
  #   respond_to do |format|
  #     format.json { render :json=> exception.to_json, :status => :forbidden }
  #   end
  # end


#  acts_as_token_authentication_handler_for User



  rescue_from ActiveRecord::RecordNotFound do |ex|
    err = {}
    err['error'] = ex.message
    render :json => err ,:status=>409
  end

  rescue_from ActiveRecord::RecordInvalid do |ex|
    p ex
    err = {}
    err['error'] = ex.message
    render :json => err ,:status=>422

  end


end
