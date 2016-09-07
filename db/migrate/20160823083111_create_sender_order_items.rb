class CreateSenderOrderItems < ActiveRecord::Migration
  def change
    create_table :sender_order_items do |t|
      t.string :order_id
      t.string :item_attributes , :limit => 2048
      t.decimal :unit_price ,:precision => 18, :scale => 3 ,:default=>0.00
      t.integer :quantity
      t.decimal :total_amount , :precision =>18, :scale =>3 ,:default=>0.00
      t.decimal :tax
      t.string :item_type
      t.string :item_subtype
      t.string :img , :limit => 1024

      t.timestamps null: false
    end
  end
end
