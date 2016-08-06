class CarrierController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

    include CarrierHelper

  def new



    respond_to do |format|


      carrier = CarrierHelper.create_new_carrier params
      #format.html  # index.html.erb
      format.json  { render :json => carrier }
    end

  end




  def all

      respond_to do |format|

      all_carriers = CarrierHelper.get_all_carriers
      #format.html  # index.html.erb
      format.json  { render :json => all_carriers }
    end

  end

end
