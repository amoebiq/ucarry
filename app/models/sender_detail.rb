class SenderDetail < ActiveRecord::Base

  validates :email_id , :presence=>true
  validates :phone , :presence=>true , :uniqueness =>true
  validates :first_name, :presence=>true
  validates :last_name , :presence=>true

end
