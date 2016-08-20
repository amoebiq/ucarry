class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  require_relative '../../lib/utilities/ucarry_constants'

  protect_from_forgery with: :exception


  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found

   err = {}
   err['error'] = UcarryConstants::RECORD_NOT_FOUND
   render :json => err
  end


end
