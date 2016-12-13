class CreateOtps < ActiveRecord::Migration
  def change
    create_table :otps do |t|
      t.string :phone
      t.string :otp
      t.string :status
      t.datetime :expiry

      t.timestamps null: false
    end
  end
end
