class AddRefsToSenderOrders < ActiveRecord::Migration
  def change

    add_column :sender_orders,:ref_1 , :string
    add_column :sender_orders,:ref_2 , :string
    add_column :sender_orders,:ref_3 , :string
  end
end
