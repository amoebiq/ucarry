class CreateOrderTransactionHistories < ActiveRecord::Migration
  def change
    create_table :order_transaction_histories do |t|
      t.string :transaction_id
      t.string :carrier_id
      t.string :order_id
      t.decimal :open_amount , :precision => 18, :scale => 3 ,:default=>0.00
      t.decimal :applied_amount , :precision => 18, :scale => 3 ,:default=>0.00
      t.decimal :pending_applied_amount , :precision => 18, :scale => 3 ,:default=>0.00
      t.string :status

      t.timestamps null: false
    end
  end
end
