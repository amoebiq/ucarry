class CreateSenderDetails < ActiveRecord::Migration
  def change
    create_table :sender_details do |t|
      t.string :sender_id
      t.string :email_id
      t.string :first_name
      t.string :last_name
      t.string :img_link , :limit => 1024
      t.string :phone
      t.string :status
      t.date :deleted_at

      t.timestamps null: false
    end
  end
end
