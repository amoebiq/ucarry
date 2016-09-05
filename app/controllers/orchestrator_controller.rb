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

    def get_coupon_details
      logger.debug "in fetch for #{params}"

      begin
        respond_to do |format|


          details = OrchestratorHelper.get_coupon params[:code]
          #format.html  # index.html.erb
          format.json  { render :json => details}
        end

      rescue Exception=>e
        p "--Error --- #{e}"
        render json:  {error: e.message ,:status=>400}
      end

    end

      def deactivate

          logger.debug "in deactivate for coupon #{params}"
          begin
              status = OrchestratorHelper.deactivate_coupon params[:code]
              respond_to do |format|
                format.json { render :json => status.to_json}
              end
          rescue Exception =>e
                p e
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
        p e
        render :json => e.message , :status=>404



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
      resp = orch.get_all_orders

      respond_to do |format|


        format.json { render :json => resp , :status => 200}

      end
    rescue Exception=>e
      error = {}
      error['error'] = e.message
      render :json => error , :status => 400
    end

  end



end
