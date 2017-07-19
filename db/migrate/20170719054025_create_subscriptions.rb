class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.string :comments
      t.string :ref_1

      t.timestamps null: false
    end
  end
end
