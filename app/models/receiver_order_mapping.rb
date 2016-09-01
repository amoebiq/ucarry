class ReceiverOrderMapping < ActiveRecord::Base

  belongs_to :sender_order
  belongs_to :sender_detail
end
