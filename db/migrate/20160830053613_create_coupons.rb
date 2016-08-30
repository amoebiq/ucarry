class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.decimal :discount
      t.string :status

      t.timestamps null: false
    end
  end
end
