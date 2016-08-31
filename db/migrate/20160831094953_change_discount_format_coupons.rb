class ChangeDiscountFormatCoupons < ActiveRecord::Migration
  def self.up
    change_column :coupons, :discount , :decimal , :precision=>10 ,:scale => 6
  end


end
