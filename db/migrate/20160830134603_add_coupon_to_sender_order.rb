class AddCouponToSenderOrder < ActiveRecord::Migration
  def change
    add_column :sender_orders, :coupon, :string
    add_column :sender_orders, :isInsured, :boolean
  end
end
