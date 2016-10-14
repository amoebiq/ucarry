class AddKeysToCarrierScheduleDetails < ActiveRecord::Migration
  def change
    add_column :carrier_schedule_details, :ready_to_carry, :string
    add_column :carrier_schedules, :stop_overs , :string , :limit =>3072
    add_column :carrier_schedules, :from_geo_long , :string , :precision => 10, :scale => 6
    add_column :carrier_schedules, :to_geo_long , :string , :precision => 10, :scale => 6

  end
end
