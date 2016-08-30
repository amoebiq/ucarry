class OrchestratorService

  def initialize(params)

    @params = params

  end

  def self.get_instance params
    new(params)
  end

  def calculate_order_costs
        id = @params
        @orders = SenderOrderItem.where(:order_id=>id)
        @orders.each do |o|
          order_item = SenderOrderItem.where(:id=>o[:id]).first
          unit_price = o[:unit_price]
          quantity = o[:quantity]
          p "Here #{unit_price} #{quantity}"
          ActiveRecord::Base.transaction do
            order_item[:total_amount]=unit_price * quantity
            order_item.save!
          end

        end

  end

end