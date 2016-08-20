class CreateCarrierScheduleDetails < ActiveRecord::Migration
  def change
    create_table :carrier_schedule_details do |t|
      t.string :schedule_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :mode
      t.string :capacity

      t.timestamps null: false
    end
  end
end
