class BankDetail < ActiveRecord::Base

  has_one :user,:foreign_key => 'uid' , :primary_key => 'uid'

end
