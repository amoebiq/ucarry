class CreateSenderOrders < ActiveRecord::Migration
  def change
    create_table :sender_orders do |t|
      t.string :order_id
      t.string :sender_id
      t.string :from_loc
      t.string :to_loc
      t.decimal :total_amount , :precision => 18 , :scale => 3
      t.decimal :from_geo_lat, :precision=> 10, :scale => 6
      t.string :from_geo_long, :precision => 10, :scale => 6
      t.string :to_geo_long, :precision => 10, :scale => 6
      t.decimal :to_geo_lat, :precision => 10, :scale => 6
      t.string :status
      t.string :comments
      t.string :type

      t.timestamps null: false
    end
  end
end
