class OrchestratorService

  require 'net/http'
  require_relative '../../lib/utilities/orchestrator_utility.rb'

  def initialize(params)

    @params = params

  end

  def self.get_instance params
    new(params)
  end

  def calculate_order_costs
        id = @params[:order_id]
        @orders = SenderOrderItem.where(:order_id=>id)
        lat1 = @params[:from_geo_lat]
        lat2 = @params[:to_geo_lat]
        long1 = @params[:from_geo_long]
        long2 = @params[:to_geo_long]
        is_insured = @params[:isInsured]
        c = @params[:coupon]
        p "coupon is #{c}"

          @coupon = Coupon.where(:name=>c).first unless c.nil?

          discount = @coupon[:discount] unless @coupon.nil?
          if discount.nil?
            discount = 0

          end
        total_amount = 0
        @orders.each do |o|
          order_item = SenderOrderItem.where(:id=>o[:id]).first
          item_att = o[:item_attributes]
          p item_att
          item_attributes = JSON.parse(item_att.to_json)
          p "XXXX"
          p item_attributes
          length = item_attributes['length'].to_f
          breadth = item_attributes['breadth'].to_f
          height = item_attributes['height'].to_f
          item_weight = item_attributes['item_weight'].to_f
          item_value  = item_attributes['item_value'].to_f



          resp = self.update_cost_details(lat1 , lat2 , long1 , long2 , length , height , breadth , item_weight , item_value , is_insured)
          p "DDD is "
          p resp
          r = JSON.parse(resp.to_json)
          q = r['quote']
          p "XXXX is #{q}"
          p q['total_charge']
          unit_price = q['total_charge'].to_f
          quantity = o[:quantity].to_i
          p "Here #{unit_price} #{quantity}"
          ActiveRecord::Base.transaction do
            order_item[:unit_price] = unit_price
            order_item[:total_amount]=(unit_price * quantity)-(unit_price * quantity * discount)/100;
            order_item[:item_attributes] = q
            order_item.save!
            total_amount += order_item[:total_amount]
          end

        end

        ActiveRecord::Base.transaction do
          SenderOrder.where(:order_id=>id).update_all(:total_amount=>total_amount)
        end

  end

  def volumetric_weight
    length = @params[:length].to_f
    height = @params[:height].to_f
    breadth = @params[:breadth].to_f

    p "#{breadth} --- #{height} ---- #{length}"

    vol = Volumetric.where(:status=>true).first
    coeff = vol[:coefficient].to_f
    p "coeff is #{coeff}"
    vw = (length * breadth * height) / coeff
    resp = {}
    resp['volumetric_weight'] = vw
    resp

  end

  def update_cost_details(lat1 , lat2 , long1 , long2 , length , height , breadth , item_weight , item_value , is_insured)

    resp = self.quote_calc(lat1,lat2,long1,long2,length,height,breadth,item_weight,item_value,is_insured)

  end

  def get_quote

    lat1 = @params[:lat1]
    lat2 = @params[:lat2]
    long1 = @params[:long1]
    long2 =  @params[:long2]

    length = @params[:length].to_f
    height = @params[:height].to_f
    breadth = @params[:breadth].to_f

    item_weight = @params[:item_weight].to_f
    item_value = @params[:item_value].to_f

    is_insured = @params[:is_insured]

    resp = self.quote_calc(lat1,lat2,long1,long2,length,height,breadth,item_weight,item_value,is_insured)

    resp

  end

  def quote_calc (lat1 , lat2 , long1 , long2 , length , height , breadth , item_weight , item_value , is_insured)




    p "#{lat1} ---- #{long1}  ----- #{lat2} ----- #{long2}---------------- #{length}"


    #total_distance = Geocoder::Calculations.distance_between([lat1,long1],[lat2,long2])

    #http://maps.googleapis.com/maps/api/distancematrix/json?origins=11.8013643,76.0043731&destinations=12.2958104,76.6393805&mode=driving&sensor=false

    base_uri = "http://maps.googleapis.com/maps/api/distancematrix/json?origins="
    base_uri = base_uri + "#{lat1},#{long1}&destinations=#{lat2},#{long2}&mode=driving&sensor=false"


    url = URI.parse(base_uri)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    puts res.body

    resp = JSON.parse(res.body)

    p resp

    p base_uri

    total_distance= resp["rows"][0]["elements"][0]["distance"]["value"]

    p "Total distance is #{total_distance}"


    resp = {}
    params = {}

    volumetric = Volumetric.where(:name=>'VOLUMETRIC_COFF').first
    volumetric_coeff = volumetric[:coefficient].to_f
    distance = Volumetric.where(:name=>'DISTANCE_COEFF').first
    distance_coeff = distance[:coefficient].to_f
    base = Volumetric.where(:name=>'BASE_WEIGHT').first
    base_weight = base[:coefficient].to_f
    base_weight_c = Volumetric.where(:name=>'BASE_WEIGHT_CHARGE').first
    base_weight_charge = base_weight_c[:coefficient].to_f
    extra_w = Volumetric.where(:name=>'EXTRA_WEIGHT').first
    extra_weight = extra_w[:coefficient].to_f
    extra_weight_c = Volumetric.where(:name=>'EXTRA_WEIGHT_CHARGE').first
    extra_weight_charge = extra_weight_c[:coefficient].to_f
    insurance_c = Volumetric.where(:name=>'INSURANCE_PERCENT').first
    insurance_percent = insurance_c[:coefficient].to_f

    service_c = Volumetric.where(:name=>'SERVICE_CHARGE').first
    service_charge = service_c[:coefficient].to_f
    risk_c = Volumetric.where(:name=>'RISK_CHARGE').first
    risk_charge = risk_c[:coefficient].to_f





    calculate_weight = 1

    cost_of_distance = total_distance * distance_coeff
    volumetric_weight = (length * breadth * height) / volumetric_coeff

    if(item_weight > volumetric_weight)

      p "item weight is higher ... "
      calculate_weight = item_weight

    else

      calculate_weight = volumetric_weight

    end
    total_weight_price = 0
    if calculate_weight < base_weight
      total_weight_price = base_weight_charge
    else
      total_weight_price = base_weight_charge + ((calculate_weight - base_weight)/extra_weight)*extra_weight_charge
    end

    total_distance_charge = total_distance/1000.00 * distance_coeff
    params['length'] = length
    params['breadth'] = breadth
    params['height'] = height
    params['per_km_charge'] = distance_coeff
    params['total_distance'] = total_distance

    params['total_distance_charge'] = total_distance_charge
    params['total_weight_charge'] = total_weight_price

    total_charges = total_distance_charge + total_weight_price
    insurance_charge = 0
    p "insured is #{is_insured}"
    if is_insured
        insurance_charge = (total_charges * insurance_percent)/100.00
        total_charges = total_charges + insurance_charge

    end

    params['insurance_percent'] = insurance_percent
    params['insurance_charge'] = insurance_charge
    params['risk_charge'] = risk_charge

    service_charge_commission = (total_charges * service_charge)/100.00
    params['service_charge_percent'] = service_charge
    params['service_charge'] = service_charge_commission
    total_charges = total_charges + service_charge_commission

    params['total_charge'] = total_charges

    resp['quote'] = params

    resp


  end


  def get_all_schedules

    search_params=""
    from_loc = @params[:from_loc]
    to_loc = @params[:to_loc]
    start_time = @params[:start_time]
    end_time = @params[:end_time]

    where = {}
    where["from_loc"]  = @params[:from_loc] if @params[:from_loc].present?
    where["to_loc"]  = @params[:to_loc] if @params[:to_loc].present?
    where["status"] = 'active'
    child_where = {}
    child_where["carrier_schedule_details.start_time"] = @params[:start_time] if @params[:start_time].present?
    child_where["carrier_schedule_details.end_time"] = @params[:end_time] if @params[:end_time].present?


    @schedules = CarrierSchedule.where(where)
    @schedules = CarrierSchedule.where(where).joins(:carrier_schedule_detail).where(child_where)
    #@schedules = @schedules.CarrierScheduleDetail.where("start_time" => "2016-02-12 12:00:00")
    @schedules.to_json(:include => :carrier_schedule_detail)


  end

  def get_all_orders

    from_loc = @params[:from_loc]
    to_loc = @params[:to_loc]
    start_time = @params[:start_time]
    end_time = @params[:end_time]

    where = {}
    where["from_loc"]  = @params[:from_loc] if @params[:from_loc].present?
    where["to_loc"]  = @params[:to_loc] if @params[:to_loc].present?
    where["status"] = 'active'

    child_where = {}


    #@schedules = SenderOrder.relevant(from_loc,to_loc)
    @schedules = SenderOrder.relevant(from_loc,to_loc)
    if @schedules.size==0
      message = {}
      message['message'] = 'No orders found!'
      return message,404
    end

    #@schedules = @schedules.CarrierScheduleDetail.where("start_time" => "2016-02-12 12:00:00")
    return @schedules.to_json(:include => [:sender_order_item,:rating]) , 200




  end

  def accept_order uid

    carrier_id = uid
    order_id = @params[:order_id]

    p "XXX #{carrier_id} --- #{order_id}"
    @order = SenderOrder.where(:order_id => order_id).first
    if(@order.nil?)
      error = {}
      error['error'] = 'Order Not Found'
      return error , 403
    end
    if(!@order.status.eql?'active')
      error = {}
      error['error'] = 'Order not active now'
      return error,404
    end

    ActiveRecord::Base.transaction do


    @order.status = 'scheduled'
    @order.save!

    @otm = OrderTransactionHistory.new
    @otm.order_id = order_id
    @otm.carrier_id = carrier_id
    @otm.status = 'scheduled'
    @otm.open_amount = @order.total_amount
    @otm.transaction_id = OrchestratorUtility.generate_id
    @otm.save!

    end

    sender_id = @order[:sender_id]
    o_id = @otm.order_id
    p "o_id is #{o_id}"
    # @sender_details = SenderDetail.where(:sender_id => sender_id).first
    # s_phone = @sender_details[:phone]
    # s_name = @sender_details[:first_name] + ' ' +@sender_details[:last_name]

    nf = NotifyService.new(@otm)
    nf.accept_order
    resp = {}
    resp['status'] = 'order accepted'
    resp['order_id'] = order_id
    resp['total_amount'] = @otm.open_amount




    return resp,200

  end


  def rate_sender

    rating = @params[:rating]
    comments = @params[:comments]
    order_id = @params[:order_id]
    rated_by = @params[:carrier_id]
    order = SenderOrder.where(:order_id => order_id).first
    sender = order[:sender_id]

    if rating < 1 or rating > 5
      resp = {}
      resp['error'] = 'Rating should be between 1 and 5'

      return resp , 400
    end

    ActiveRecord::Base.transaction do

      @rating = Rating.new
      @rating.user = sender
      @rating.rated_by = rated_by
      @rating.comments = comments unless comments.nil?
      @rating.rating = rating

      @rating.save!

      resp = {}
      resp['message'] = 'Thank You !'

      return resp , 201

    end

  end

  def rate_carrier

    rating = @params[:rating]
    comments = @params[:comments]
    order_id = @params[:order_id]
    rated_by = @params[:sender_id]
    order = OrderTransactionHistory.where(:order_id => order_id).first
    carrier = order[:carrier_id]

    if rating < 1 or rating > 5
      resp = {}
      resp['error'] = 'Rating should be between 1 and 5'

      return resp , 400
    end

    ActiveRecord::Base.transaction do

      @rating = Rating.new
      @rating.user = carrier
      @rating.rated_by = rated_by
      @rating.comments = comments unless comments.nil?
      @rating.rating = rating

      @rating.save!

      resp = {}
      resp['message'] = 'Thank You !'

      return resp , 201

    end

  end

  def send_otp

    pin = rand(0000..9999).to_s.rjust(5, "0")

     ActiveRecord::Base.transaction do

      phone_number = @params[:phone_number]

      @existing = Otp.where(:phone => phone_number).last
      p @existing
      if !@existing.nil?
        @existing.status = 'aborted'
        @existing.save!
      end
      @otp = Otp.new
      @otp.phone = phone_number
      @otp.otp = pin
      @otp.status = 'Verification Pending'
      @otp.expiry = Time.now + 15*60

      @otp.save!

      resp = {}
      resp['message'] = 'Successfully send the otp'

      twilio_client =   Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])


      r = twilio_client.messages.create(
          :to => phone_number,
          :from => ENV['TWILIO_PHONE_NUMBER'],
          #body: "Your KarrierBay OTP is #{pin} . Please enter this to verify your number")
          :body => "Your OTP for KarrierBay is #{pin} . Please keep this confidential .")



      return resp , 200

    end



  end

  def verify_otp

    phone_number = @params[:phone_number]
    otp_to_verify = @params[:otp]

    ActiveRecord::Base.transaction do

      @existing = Otp.where(:phone => phone_number,:status=>'Verification Pending').first
      p @existing
      if @existing.nil?

        message = {}
        message['error'] = 'OTP not yet generated'
        return message , 400

      end

        otp = @existing[:otp]

      if otp.eql?otp_to_verify
        @existing.status = 'verified'
        @existing.save!

        message = {}
        message['message'] = 'Successfully Verified the number'
        return message,200
      else

        message = {}
        message['error'] = 'incorrect OTP entered'

        return message , 400

      end

    end
  end


  def upload_image

    picture = @params[:picture]

    ActiveRecord::Base.transaction do

      @userdoc = Userdoc.new
      @userdoc.picture = picture
      @userdoc.save!

      resp = {}
      resp['message'] = 'uploaded successfully'
      resp['url'] = @userdoc.picture.url
      return resp , 200

    end


  end

end