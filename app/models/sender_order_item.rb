class SenderOrderItem < ActiveRecord::Base
  belongs_to :sender_order
  serialize :item_attributes, JSON
end
