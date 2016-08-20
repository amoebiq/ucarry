class CarrierSchedule < ActiveRecord::Base

  has_one :carrier_schedule_detail , foreign_key: 'schedule_id' , autosave: true ,primary_key: 'schedule_id'
  accepts_nested_attributes_for :carrier_schedule_detail

end
