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

  def self.create_carrier_schedule carrier_id ,params

    ActiveRecord::Base.transaction do

        @carrier_schedule = CarrierSchedule.new(carrier_schedule_params(params))
        @carrier_schedule.schedule_id = CarrierUtility.generate_carrier_schedule_id
        @carrier_schedule.carrier_id = carrier_id
        @carrier_schedule.status = 'active'

        p params['carrier_schedule_detail']
        #CarrierService.save_schedule_details carrier_id , params['carrier_schedule_detail']

        @carrier_schedule.save!



      @carrier_schedule
    end

  end

  def self.carrier_params params
    params.require(:carrier_detail).permit(:email_id, :first_name, :last_name, :img_link, :phone)
  end

  def self.carrier_params_details params
    params.require(:carrier_detail).permit(:email_id,:img_link, :phone)
  end

  def self.carrier_schedule_params params
    params.fetch(:carrier_schedule).permit(:from_loc,:to_loc,:from_geo_lat,:to_goe_lat,:comments,carrier_schedule_detail_attributes: [:id,:start_time,:end_time,:mode ,:capacity])
  end

end
