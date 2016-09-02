class AdminController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  include AdminHelper

  def update_volumetric

    logger.debug "In update volumetric"

    begin
        vol = AdminHelper.update_volumetric params[:volumetric]
        respond_to do |format|
          format.json {render :json => vol , :status => 204}
        end
    rescue Exception=>e

      error = {}
      error['error'] = e.message
      render :json => error ,  :status => 400

    end

  end

  def get_volumetric_data
    begin
      vol = AdminHelper.get_volumetric
      respond_to do |format|
        format.json {render :json => vol , :status => 200}
      end
    rescue Exception=>e

      error = {}
      error['error'] = e.message
      render :json => error ,  :status => 400

    end

  end




end
