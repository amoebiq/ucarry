class CreateUserdocs < ActiveRecord::Migration
  def change
    create_table :userdocs do |t|
      t.string :uid
      t.string :type
      t.string :url
      t.attachment :picture
      t.timestamps null: false
    end
  end
end
