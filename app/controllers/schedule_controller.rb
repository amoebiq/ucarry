class ScheduleController < ApplicationController

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :validate_params

  def to_location

    p params

    schedules = ScheduleHelper.get_all_to_schedules params[:to_loc]
    respond_to do |format|

      format.json { render :json => schedules}

    end

  end

   protected
   def validate_params

   end

end
