class SenderOrder < ActiveRecord::Base

  has_many :sender_order_item, :foreign_key => 'order_id' , :autosave => true , :primary_key => 'order_id'
  has_many :rating, :foreign_key => 'user' , :autosave => true , :primary_key => 'sender_id'
  has_one :user , :foreign_key => 'uid' , :primary_key => 'sender_id'
  accepts_nested_attributes_for :sender_order_item
  has_one :receiver_order_mapping , :foreign_key => 'order_id' ,:primary_key => 'order_id'
  has_one :pickup_order_mapping, :foreign_key => 'order_id', :primary_key => 'order_id'
  has_many :order_transaction_history, :foreign_key => 'order_id' , :autosave => false , :primary_key => 'order_id'


  default_scope { order(updated_at: :desc)}

  def self.filter()
    self.sender_order_item.where("created_at<'2017-01-01'")
  end

  scope :relevant, -> (from_loc,to_loc) {


    where("(from_loc LIKE ? or to_loc LIKE ?) and status='active'" , "%#{from_loc}%"  , "%#{to_loc}%")

  }

  scope :named_like, (
                   lambda do |from_loc,to_loc|

                     if !from_loc.empty?
                       self.where("from_loc LIKE ?", "%#{from_loc}%")
                     end
                     if !to_loc.empty?
                       self.where("to_loc LIKE ?", "%#{to_loc}%")
                     end

                   end


                   )


end
