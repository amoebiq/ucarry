class OrchestratorController < ApplicationController


  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
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
      p "--Error --- #{e}"
      render json:  {error: e.message ,:status=>400}
    end

  end

end
