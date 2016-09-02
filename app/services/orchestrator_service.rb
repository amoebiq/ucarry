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

  def get_volumetric_wight
    length = @params[:length].to_f
    height = @params[:height].to_f
    breadth = @params[:breadth].to_f

    p "#{breadth} --- #{height} ---- #{length}"

    vol = Volumetric.where(:status=>true).first
    coeff = vol[:coefficient].to_f
    p "coeff is #{coeff}"
    vw = (length * breadth * height) / coeff
    resp = {}
    resp['volumetric_weight'] = vw
    resp

  end

end