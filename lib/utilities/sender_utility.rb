class SenderUtility
  CARRIER_DETAILS = "sender_detail"
  def self.generate_id carrier

    first_name = carrier[CARRIER_DETAILS]["first_name"]
    last_name = carrier[CARRIER_DETAILS]["last_name"]

    "Sender"+first_name+last_name

  end

end