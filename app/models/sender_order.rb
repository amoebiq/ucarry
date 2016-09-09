class SenderOrder < ActiveRecord::Base

  has_many :sender_order_item, foreign_key: 'order_id' , autosave: true ,primary_key: 'order_id'
  accepts_nested_attributes_for :sender_order_item
  has_one :receiver_order_mapping , foreign_key: 'order_id',primary_key: 'order_id'

  default_scope { order(updated_at: :desc) }


end
