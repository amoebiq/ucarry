class CreatePickupOrderMappings < ActiveRecord::Migration
  def change
    create_table :pickup_order_mappings do |t|
      t.string :name
      t.string :order_id
      t.string :sender_id
      t.string :phone
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
