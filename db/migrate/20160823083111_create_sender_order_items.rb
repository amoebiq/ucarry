class CreateSenderOrderItems < ActiveRecord::Migration
  def change
    create_table :sender_order_items do |t|
      t.string :order_id
      t.string :item_attributes
      t.decimal :unit_price
      t.integer :quantity
      t.decimal :total_amount
      t.decimal :tax
      t.string :item_type
      t.string :item_subtype
      t.string :img

      t.timestamps null: false
    end
  end
end
