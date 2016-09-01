module SenderHelper
  require_relative '../../lib/utilities/sender_utility.rb'
  require_relative '../services/orchestrator_service'

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

    coupon = params[:sender_order][:coupon]


    unless coupon.nil?

      c = Coupon.where(:name=>coupon).first
   
      if c.nil?
        error = {}
        error['error'] = 'Coupon Not Found!!!'
        raise error.to_json
      end
    end

    begin
    ActiveRecord::Base.transaction do
      p params
      p sender_id
      @order = SenderOrder.new(sender_order_params(params))
      @order.order_id = SenderUtility.generate_order_id
      @order.sender_id = sender_id
      @order.status = 'active'
      #Resque.enqueue(Sleeper, 15)
      @order.save!







    end

     orch = OrchestratorService.new(@order)
      orch.calculate_order_costs
     @order.to_json(:include => :sender_order_item)
    rescue Exception=>e
      p e
    end

  end

  def self.get_all_orders sender_id

    @orders = SenderOrder.where(:sender_id => sender_id)
    @orders

  end

  def self.update_reciever_details sender_id,order_id,params

      ActiveRecord::Base.transaction do

        @reciever = ReceiverOrderMapping.new(reciever_params(params))
        @reciever.sender_id = sender_id
        @reciever.order_id = order_id
        @reciever.reciever_id = SenderUtility.generate_reciever_id
        @reciever.status = 'active'



        @reciever.save!

      end

    @reciever
  end


  def self.edit_reciever_details params

    ActiveRecord::Base.transaction do

      @mapping = ReceiverOrderMapping.find(params[:id])
      if @mapping.blank?

        raise ActiveRecord::RecordNotFound
      end
      if @mapping.update_attributes(reciever_params(params))
        return @mapping

      else

      end




    end

  end

  def self.reciever_params params

    params.require(:receiver_order_mapping).permit(:name, :phone_1, :phone_2, :address_line_1, :address_line_1,:state,:landmark,:pin,:status,:auto_save)

  end
  def self.carrier_params params
    params.require(:sender_detail).permit(:email_id, :first_name, :last_name, :img_link, :phone)
  end

  def self.carrier_params_details params
    params.require(:sender_detail).permit(:email_id,:img_link, :phone)
  end

  def self.sender_order_params params
    params.fetch(:sender_order).permit(:from_loc,:to_loc,:from_geo_lat,:to_goe_lat,:from_geo_long,:to_geo_long,:status,:type,:comments,:coupon,:isInsured,sender_order_item_attributes: [:id,:item_attributes,:unit_price,:quantity ,:item_type,:item_subtype,:img])
  end


end
