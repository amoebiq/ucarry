class CarrierController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :validate_params

    include CarrierHelper

  # ActionController::Parameters.action_on_unpermitted_parameters = :raise
  #
  # rescue_from(ActionController::UnpermittedParameters) do |pme|
  #   logger.debug "Some unwanted params"
  #   render json: { error:  { unknown_parameters: pme.params } },
  #       status: :bad_request
  # end

  def new




    begin
    respond_to do |format|


      carrier = CarrierHelper.create_new_carrier params
      #format.html  # index.html.erb
      format.json  { render :json => carrier ,:status => :created}
    end

    rescue Exception=>e
      p "--Error --- #{e}"
      render json:  {error: e.message ,:status=>400}
    end



  end




  def all

      respond_to do |format|

      all_carriers = CarrierHelper.get_all_carriers
      #format.html  # index.html.erb
      format.json  { render :json => all_carriers }
    end

  end

  def deactivate

    p params
    msg = CarrierHelper.deactivate_carrier params[:id]
    respond_to do |format|

      format.json { render :json => msg}

    end

  end

  def create_carrier_schedule

    logger.debug "in create carrier schedule"
    logger.debug params

    schedule = CarrierHelper.create_carrier_schedule params[:id] , params[:carrier]

    respond_to do |format|

      format.json { render :json => schedule ,:status => :created}

    end

  end

  def cancel_carrier_schedule

    logger.debug "in cancel carrier schedule"
    logger.debug params

    begin



    status = CarrierHelper.cancel_carrier_schedule params[:id],params[:schedule_id]


    respond_to do |format|

      format.json { render :json => status}

    end
    rescue Exception=>e
      p e
      render :json => e.message , :status=>403
    end


  end


  def get_all_schedule

    logger.debug "in get all schedules"

    carriers = CarrierHelper.get_all_carrier_schedules params[:id]

    respond_to do |format|

      format.json { render :json => carriers}

    end

  end

  def details
    details = CarrierHelper.get_carrier_details params[:id]
    respond_to do |format|
      format.json { render :json => details}
    end
  end




  protected
      def validate_params
      logger.debug "in validate_params"
        p params

      end


end
