class ChangeUnitPriceInSenderOrderItems < ActiveRecord::Migration
  def self.up
    change_column :sender_order_items, :unit_price , :decimal , :precision=>10 ,:scale => 6
    change_column :sender_order_items, :tax , :decimal , :precision=>10 ,:scale => 6
    change_column :sender_order_items, :total_amount , :decimal , :precision=>10 ,:scale => 6

  end
end
