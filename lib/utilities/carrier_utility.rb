class CarrierUtility

  require 'date'


  CARRIER_DETAILS = "carrier_detail"
  CARRIER_SCHEDULE = "carrier_schedule"
  CARRIER = "carrier"
  SCHEDULE = "schedule"

  def self.generate_id carrier

      CARRIER + Time.now.to_i.to_s

  end

  def self.generate_carrier_schedule_id
       SCHEDULE + Time.now.to_i.to_s
  end


end