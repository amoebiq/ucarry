class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  require_relative '../../lib/utilities/ucarry_constants'
  require_relative '../../app/models/user'

  #protect_from_forgery with: :exception

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

 # protect_from_forgery with: :null_session
  before_action :print_creds

  before_action :authenticate_user!, except: [:new, :create]

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



  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found

   err = {}
   err['error'] = UcarryConstants::RECORD_NOT_FOUND
   render :json => err ,:status=>404
  end


end
