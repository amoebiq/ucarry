class CarrierService

  def self.save_schedule_details carrier_id , params

    details = {}
    details['carrier_schedule_detail'] = params
    p details
    @carrier_schedule_details = CarrierScheduleDetail.new(params)
    @carrier_schedule_details.schedule_id = carrier_id
    @carrier_schedule_details.save!

  end

end