class CreateCustomerSupports < ActiveRecord::Migration
  def change
    create_table :customer_supports do |t|
      t.string :contact_no
      t.string :name
      t.string :issue
      t.string :comments
      t.string :ref_1
      t.string :ref_2

      t.timestamps null: false
    end
  end
end
