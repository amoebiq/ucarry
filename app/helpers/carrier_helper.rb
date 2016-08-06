module CarrierHelper
  require_relative '../../lib/utilities/carrier_utility.rb'

  def self.create_new_carrier params


    @carrier = CarrierDetail.new(carrier_params(params))
    @carrier.carrier_id=CarrierUtility.generate_id params
    @carrier.status='active'

    @carrier.save!

    @carrier

  end

  def self.get_all_carriers

    CarrierDetail.where(:status => 'active')


  end

  def self.update_carrier_details carrier_id

    @carrier = CarrierDetail.find(carrier_id)
    p @carrier

  end


  def self.carrier_params params
    params.require(:carrier_detail).permit(:email_id, :first_name, :last_name, :img_link, :phone)
  end

  def self.carrier_params_details params
    params.require(:carrier_detail).permit(:email_id,:img_link, :phone)
  end

end
