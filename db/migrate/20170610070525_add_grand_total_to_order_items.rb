class AddGrandTotalToOrderItems < ActiveRecord::Migration
  def change

    add_column :sender_order_items,:grand_total , :decimal , :precision => 18 , :scale => 3

  end
end
