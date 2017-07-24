class CreateCompleteOrders < ActiveRecord::Migration
  def change
    create_table :complete_orders do |t|
      t.string :order_id
      t.string :otp
      t.string :status
      t.string :ref_1
      t.string :ref_2
      t.string :ref_3

      t.timestamps null: false
    end
  end
end
