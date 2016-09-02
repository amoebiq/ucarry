class CreateVolumetrics < ActiveRecord::Migration
  def change
    create_table :volumetrics do |t|
      t.decimal :coefficient , precision: 10, scale: 6
      t.string :updated_by
      t.boolean :status
      t.string :comments

      t.timestamps null: false
    end
  end
end
