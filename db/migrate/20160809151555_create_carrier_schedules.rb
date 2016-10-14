class CreateCarrierSchedules < ActiveRecord::Migration
  def change
    create_table :carrier_schedules do |t|
      t.string :schedule_id
      t.string :carrier_id
      t.string :from_loc
      t.string :to_loc
      t.decimal :from_geo_lat, precision: 10, scale: 6
      t.decimal :to_geo_lat, precision: 10, scale: 6
      t.string :status
      t.string :comments

      t.timestamps null: false
    end
  end
end
