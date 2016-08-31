class SenderUtility
  CARRIER_DETAILS = "sender_detail"
  CARRIER = "sender"
  ORDER = "order"
  RECIEVER = "reciever"
  def self.generate_id carrier

    CARRIER + Time.now.to_i.to_s

  end


  def self.generate_order_id
    ORDER + Time.now.to_i.to_s
  end

  def self.generate_reciever_id

    RECIEVER + Time.now.to_i.to_s

  end

end