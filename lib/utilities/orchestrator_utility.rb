class OrchestratorUtility
  TRANSACTION = "trans"
  def self.generate_id

    TRANSACTION + Time.now.to_i.to_s

  end


end