class SenderUtility
  CARRIER_DETAILS = "sender_detail"
  CARRIER = "sender"
  def self.generate_id carrier

    CARRIER + Time.now.to_i.to_s

  end

end