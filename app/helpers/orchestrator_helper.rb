module OrchestratorHelper

  ############################# Coupons ###############################
  def self.new_coupon params

    ActiveRecord::Base.transaction do

      @coupon = Coupon.new(coupon_params(params))
      @coupon.status='active'
      @coupon.save!

    end

    @coupon


  end

  def get_coupon params

  end

  def deactivate_coupon coupon_code

  end


  def self.coupon_params params
    params.require(:coupon_code).permit(:name,:discount)
  end


end
