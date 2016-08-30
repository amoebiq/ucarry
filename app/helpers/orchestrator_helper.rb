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

  def self.get_coupon code

      @coupon = Coupon.where(:name => code).first
      @coupon

  end

  def self.deactivate_coupon coupon_code

    @coupon = Coupon.where(:name => coupon_code).first
    curr_status = @coupon.status
    p curr_status
    if curr_status.eql?"inactive"
      error = {}
      error["error"] = "Already inactive coupon"
      raise error.to_json
    end
    @coupon.status='inactive'
    @coupon.save!

    resp = {}
    resp["status"] = "Successfully deactivated the coupon"

    resp

  end


  def self.coupon_params params
    params.require(:coupon_code).permit(:name,:discount)
  end

  def self.get_all_coupons
    @coupons = Coupon.where(:status=>'active')
    if @coupons.nil? or @coupons.empty?
      error = {}
      error["error"] = "No record found"
      raise error.to_json
    end
    @coupons
  end
end
