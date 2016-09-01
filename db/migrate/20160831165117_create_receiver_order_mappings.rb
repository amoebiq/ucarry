class CreateReceiverOrderMappings < ActiveRecord::Migration
  def change
    create_table :receiver_order_mappings do |t|
      t.string :reciever_id
      t.string :order_id
      t.string :sender_id
      t.string :name
      t.string :phone_1
      t.string :phone_2
      t.string :address_line_1
      t.string :address_line_2
      t.string :state
      t.string :landmark
      t.string :pin
      t.string :status
      t.boolean :auto_save

      t.timestamps null: false
    end
  end
end
