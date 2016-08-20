class CarrierUtility

  require 'date'


  CARRIER_DETAILS = "carrier_detail"
  CARRIER_SCHEDULE = "carrier_schedule"
  CARRIER = "carrier"
  SCHEDULE = "schedule"

  def self.generate_id carrier

      first_name = carrier[CARRIER_DETAILS]["first_name"]
      last_name = carrier[CARRIER_DETAILS]["last_name"]

      "carrier"+first_name+last_name

  end

  def self.generate_carrier_schedule_id
       SCHEDULE + Time.now.to_i.to_s
  end


end