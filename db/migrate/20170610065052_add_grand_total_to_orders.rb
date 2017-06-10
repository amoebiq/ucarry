class AddGrandTotalToOrders < ActiveRecord::Migration
  def change

    add_column :sender_orders,:grand_total , :decimal , :precision => 18 , :scale => 3

  end
end
