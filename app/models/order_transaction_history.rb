class OrderTransactionHistory < ActiveRecord::Base

  has_many :sender_order,:foreign_key => 'order_id' , :primary_key => 'order_id'
end
