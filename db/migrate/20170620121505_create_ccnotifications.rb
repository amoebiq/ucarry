class CreateCcnotifications < ActiveRecord::Migration
  def change
    create_table :ccnotifications do |t|
      t.string :user_id
      t.string :order_schedule_id
      t.string :type
      t.string :message
      t.string :ref_1
      t.string :ref_2
      t.string :ref_3
      t.string :ref_4

      t.timestamps null: false
    end
  end
end
