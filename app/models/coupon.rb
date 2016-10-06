class Coupon < ActiveRecord::Base

  validates :name , :presence => true , :uniqueness => true

end
