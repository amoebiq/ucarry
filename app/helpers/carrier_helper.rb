module CarrierHelper
  require_relative '../../lib/utilities/carrier_utility.rb'
  require_relative '../../app/services/carrier_service'

  def self.create_new_carrier params


    @carrier = CarrierDetail.new(carrier_params(params))
    @carrier.carrier_id=CarrierUtility.generate_id params
    @carrier.status='active'

    ActiveRecord::Base.transaction do



    @carrier.save!

    end

    @carrier



    end

  def self.get_all_carriers

    CarrierDetail.where(:status => 'active')


  end

  def self.update_carrier_details carrier_id

    @carrier = CarrierDetail.find(carrier_id)
    p @carrier

  end

  def self.deactivate_carrier carrierd_id
    @carrier = CarrierDetail.where(:carrier_id => carrierd_id).first
    @carrier.status='inactive'
    @carrier.save!

    'Successfully Deactivate the carrier'.to_json
  end

  def self.create_carrier_schedule  params , uid

    ActiveRecord::Base.transaction do

        @carrier_schedule = CarrierSchedule.new(carrier_schedule_params(params))
        @carrier_schedule.schedule_id = CarrierUtility.generate_carrier_schedule_id
        @carrier_schedule.carrier_id = uid
        @carrier_schedule.status = 'active'

        p params['carrier_schedule_detail']
        #CarrierService.save_schedule_details carrier_id , params['carrier_schedule_detail']

        @carrier_schedule.save!






    end

    ns = NotifyService.new(@carrier_schedule)
    ns.schedule_created


    @carrier_schedule.to_json(:include => :carrier_schedule_detail)

  end

  def self.cancel_carrier_schedule carrier_id , schedule_id


    ActiveRecord::Base.transaction do

      carrier_schedule = CarrierSchedule.find_by_schedule_id(schedule_id)
      if carrier_schedule.nil?
        raise ActiveRecord::RecordNotFound
      end
      if carrier_schedule.status.eql?"cancel"
        error = {}
        error["error"] = "The schedule is already in cancelled state"
        raise error.to_json
      end
      carrier_schedule.status = 'cancel'
      carrier_schedule.save!

      message = {}
      message['status'] = 'cancelled the schedule'
      message

    end




  end

  def self.rate_sender
    ActiveRecord::Base.transaction do



    end
  end


  def self.get_all_carrier_schedules carrier_id , params

    carriers = CarrierSchedule.where(:carrier_id => carrier_id).where(:status=>'active')
    carriers = carriers.where(:to_loc=>params[:to_loc]) if params[:to_loc].present?
    carriers = carriers.where(:from_loc=>params[:from_loc]) if params[:from_loc].present?
    carriers = carriers.limit(params[:start]) if params[:start].present?
    carriers = carriers.offset(params[:offset]) if params[:offset].present?


    carriers.to_json(:include => :carrier_schedule_detail)

  end

  def self.get_carrier_details carrier_id
    details = CarrierDetail.where(:carrier_id => carrier_id).first
    details
  end

  def self.carrier_params params
    params.require(:carrier_detail).permit(:email_id, :first_name, :last_name, :img_link, :phone)
  end



  def self.carrier_params_details params
    params.require(:carrier_detail).permit(:email_id,:img_link, :phone)
  end

  def self.carrier_schedule_params params
    params[:carrier_schedule][:stop_overs] ||= []
    params.fetch(:carrier_schedule).permit(:from_loc,:to_loc,:from_geo_lat,:to_geo_lat,:from_geo_long,:to_geo_long,:comments,:stop_overs=>[],:carrier_schedule_detail_attributes=>[:id,:start_time,:end_time,:mode ,:capacity,:ready_to_carry])
  end

end
