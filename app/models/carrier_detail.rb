class CarrierDetail < ActiveRecord::Base

  validates :email_id , :presence=>true
  validates :phone , :presence=>true
  validates :first_name, :presence=>true
  validates :last_name , :presence=>true

  #has_many :carrier_schedule , foreign_key: 'carrier_id' ,primary_key: 'carrier_id'

end
