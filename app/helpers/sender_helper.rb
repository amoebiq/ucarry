module SenderHelper
  require_relative '../../lib/utilities/sender_utility.rb'

  def self.create_new_sender params

    @sender = SenderDetail.new(carrier_params(params))
    @sender.sender_id = SenderUtility.generate_id params
    @sender.status='active'
    @sender.save!

    @sender

  end

  def self.get_all_senders

    SenderDetail.where(:status => 'active')


  end

  def self.get_sender_details sender_id
    SenderDetail.where(:sender_id => sender_id)
  end

  def self.new_order sender_id , params

    begin
    ActiveRecord::Base.transaction do
      p params
      p sender_id
      @order = SenderOrder.new(sender_order_params(params))
      @order.order_id = SenderUtility.generate_order_id
      @order.sender_id = sender_id
      @order.status = 'active'

      @order.save!

      @order.to_json(:include => :sender_order_item)

    end

    rescue Exception=>e
      p e
    end

    end

  def self.carrier_params params
    params.require(:sender_detail).permit(:email_id, :first_name, :last_name, :img_link, :phone)
  end

  def self.carrier_params_details params
    params.require(:sender_detail).permit(:email_id,:img_link, :phone)
  end

  def self.sender_order_params params
    params.fetch(:sender_order).permit(:from_loc,:to_loc,:from_geo_lat,:to_goe_lat,:from_geo_long,:to_geo_long,:status,:type,:comments,sender_order_item_attributes: [:id,:item_attributes,:unit_price,:quantity ,:item_type,:item_subtype,:img])
  end


end
