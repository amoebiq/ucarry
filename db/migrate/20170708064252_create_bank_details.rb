class CreateBankDetails < ActiveRecord::Migration
  def change
    create_table :bank_details do |t|
      t.string :uid
      t.string :account_no
      t.string :ifsc
      t.string :bank_name
      t.string :ref_1
      t.string :ref_2
      t.string :ref_3

      t.timestamps null: false
    end
  end
end
