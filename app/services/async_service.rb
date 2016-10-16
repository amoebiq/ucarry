class AsyncService < Struct.new(:id , :params)

  def perform
    SenderHelper.new_order( id , params)
  end

end