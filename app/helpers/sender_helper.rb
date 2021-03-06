module SenderHelper
  require_relative '../../lib/utilities/sender_utility.rb'
  require_relative '../services/orchestrator_service'

  def self.create_new_sender params , request

    phone = params[:sender_detail][:phone]
    s = SenderDetail.where(:phone => phone).first
    # if !s.nil?
    #   error = {}
    #   error['error'] = 'phone number already exists . Please register with a different phone number'
    #   return error , 409
    # end

    @sender = SenderDetail.new(carrier_params(params))
    email = request.headers['uid']
    @sender.email_id = email
    @sender.sender_id = SenderUtility.generate_id params
    @sender.status='active'
    @sender.save!

    return @sender , 201

  end

  def self.get_all_senders

    SenderDetail.where(:status => 'active')


  end

  def self.get_sender_details sender_id
    @sender = SenderDetail.where(:sender_id => sender_id)

    @sender
  end

  def self.new_order sender_id , params


    coupon = params[:sender_order][:coupon]


    unless coupon.nil?

      c = Coupon.where(:name=>coupon).first
   
      if c.nil?
        error = {}
        error['error'] = 'Coupon Not Found!!!'
        code = 404
        return error , code
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
    @order = SenderOrder.where(:order_id => @order.order_id).first
    id = @order[:order_id]
    p "PPPAAA --- #{id}"
    reciever = params[:sender_order][:receiver_order_mapping]
    p reciever
    rec = {}
    rec['receiver_order_mapping'] = reciever
    ActiveRecord::Base.transaction do

      @reciever = ReceiverOrderMapping.new
      @reciever.sender_id = sender_id
      @reciever.order_id = id
      @reciever.reciever_id = SenderUtility.generate_reciever_id
      @reciever.status = 'active'
      @reciever.name = reciever[:name]
      @reciever.phone_1 = reciever[:phone_1]
      @reciever.phone_2 = reciever[:phone_2]
      @reciever.address_line_1 = reciever[:address_line_1]
      @reciever.address_line_2 = reciever[:address_line_2]
      @reciever.landmark = reciever[:landmark]
      @reciever.pin = reciever[:pin]
      @reciever.state = reciever[:state]
      @reciever.auto_save = reciever[:auto_save]


      @reciever.save!

    end

    pickup = params[:sender_order][:pickup_order_mapping]

    ActiveRecord::Base.transaction do

      @pickup = PickupOrderMapping.new
      @pickup.sender_id = sender_id
      @pickup.order_id = id

      @pickup.status = 'active'
      @pickup.name = pickup[:name]
      @pickup.phone = pickup[:phone_1]

      @pickup.address_line_1 = pickup[:address_line_1]
      @pickup.address_line_2 = pickup[:address_line_2]
      @pickup.landmark = pickup[:landmark]
      @pickup.pin = pickup[:pin]
      @pickup.state = pickup[:state]
      @pickup.auto_save = pickup[:auto_save]


      @pickup.save!

    end
    child_where={}
    child_where['receiver_order_mappings.order_id'] = id
      #@orders = SenderOrder.where(:order_id=>id).joins(:receiver_order_mapping).where(child_where)
    #@order = SenderOrder.where(:order_id=>id).joins(:receiver_order_mapping).where(child_where)

      ns = NotifyService.new(@order)
      ns.sender_order_created
     return @order.to_json(:include => [:receiver_order_mapping,:sender_order_item,:pickup_order_mapping]),201
    rescue Exception=>e
      p e
    end

  end

  def self.get_all_orders sender_id,params

    if(params[:my_bay].present?)


      @orders = SenderOrder.where.not(:status => 'completed').where(:sender_id => sender_id)
      return @orders.to_json(:include => [:user,:sender_order_item])

      elsif params[:my_bay_completed].present?


             @orders = SenderOrder.where(:status => 'completed').where(:sender_id => sender_id)
             return @orders.to_json(:include => [:user,:sender_order_item])


    else


    @orders = SenderOrder.where(:status => 'active').where(:sender_id => sender_id)
    @orders = @orders.where(:from_loc=>params[:from_loc]) if params[:from_loc].present?
    @orders = @orders.where(:to_loc=>params[:to_loc]) if params[:to_loc].present?
    @orders = @orders.limit(params[:limit]) if params[:limit].present?
    @orders = @orders.limit(params[:offset]) if params[:offset].present?


    return @orders.to_json(:include => [:user,:sender_order_item])



    end
    end





  def self.get_all_orders_of_all_users params,uid

    @orders = SenderOrder.where(:status => 'active').where.not(:sender_id => uid)
    @orders = @orders.where("from_loc LIKE ?","%#{params[:from_loc]}%") if params[:from_loc].present?
    @orders = @orders.where("to_loc LIKE ?", "%#{params[:to_loc]}%") if params[:to_loc].present?
    @orders = @orders.limit(params[:limit]) if params[:limit].present?
    @orders = @orders.limit(params[:offset]) if params[:offset].present?


    # @orders.each do |order|
    #
    #   order.sender_order_item.select{|item| item.start_time < Date.today}
    # end



    date_time = Date.today
    p "Date is #{date_time}"

    @orders = @orders.joins(:sender_order_item).where("sender_order_items.start_time > '#{date_time} 00:00:00'")
    @orders.to_json(:include => [:user,:sender_order_item])#.where('sender_order_items.unit_price>0')
    #@order.joins(:sender_order_items)


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

  def self.cancel_order uid,params
    order_id = params[:order_id]
    comments = params[:comments]

    ActiveRecord::Base.transaction do

      @order = SenderOrder.where(:order_id => order_id).first

      if @order.nil?
        return SenderHelper.custom_msg('order not found!!!'),404
      end
      status = @order[:status]
      if status.eql?'cancel'
        return SenderHelper.custom_msg('already cancelled order !!!') , 403
      end

      if SenderOrder.where(:order_id => order_id).update_all(:status => 'cancel')
        SenderOrder.where(:order_id => order_id).update_all(:comments => comments) unless comments.nil?
        OrderTransactionHistory.where(:order_id => order_id).update_all(:status => 'cancel')
        msg = {}
        msg['status'] = 'Succesfully Cancelled'

        ##### TO DO - Should send notification to carrier if status is scheduled #############

        return msg , 200
      end
    end
  end



  def self.custom_msg msg
    error = {}
    error['error'] = msg
    return error
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
    params.fetch(:sender_order).permit(:from_loc,:to_loc,:from_geo_lat,:to_geo_lat,:from_geo_long,:to_geo_long,:status,:type,:comments,:coupon,:isInsured,:sender_order_item_attributes=> [:id,:unit_price,:quantity ,:item_type,:item_subtype,:img,:start_time,:end_time,:item_attributes=> [:length,:breadth,:height,:item_weight,:item_value] ,:receiver_order_mapping=>[:name, :phone_1, :phone_2, :address_line_1, :address_line_1,:state,:landmark,:pin,:status,:auto_save] ,:pickup_order_mapping=>[:name, :phone_1, :phone_2, :address_line_1, :address_line_1,:state,:landmark,:pin,:status,:auto_save]])
  end


end
