class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :user
      t.string :rated_by
      t.string :comments
      t.integer :rating
      t.timestamps null: false
    end
  end
end
