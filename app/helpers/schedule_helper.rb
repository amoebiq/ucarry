module ScheduleHelper

  require_relative '../../lib/utilities/carrier_utility.rb'
  require_relative '../../app/services/carrier_service'


  def self.get_all_to_schedules to_loc
    schedules = CarrierSchedule.where(:to_loc => to_loc)
    schedules.to_json(:include => :carrier_schedule_detail)

  end

end
