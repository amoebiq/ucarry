class OrchestratorService

  def initialize(params)

    @params = params

  end

  def self.get_instance params
    new(params)
  end

  def calculate_order_costs
        id = @params[:order_id]
        @orders = SenderOrderItem.where(:order_id=>id)
        c = @params[:coupon]
        p "coupon is #{c}"

          @coupon = Coupon.where(:name=>c).first unless c.nil?

          discount = @coupon[:discount] unless @coupon.nil?
          if discount.nil?
            discount = 0

          end
        @orders.each do |o|
          order_item = SenderOrderItem.where(:id=>o[:id]).first
          unit_price = o[:unit_price]
          quantity = o[:quantity]
          p "Here #{unit_price} #{quantity}"
          ActiveRecord::Base.transaction do
            order_item[:total_amount]=(unit_price * quantity)-(unit_price * quantity * discount)/100;
            order_item.save!
          end

        end

  end

end