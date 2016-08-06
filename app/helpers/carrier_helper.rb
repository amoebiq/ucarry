module CarrierHelper
  require_relative '../../lib/utilities/carrier_utility.rb'

  def self.create_new_carrier params


    @carrier = CarrierDetail.new(carrier_params(params))
    @carrier.carrier_id=CarrierUtility.generate_id params
    @carrier.status='active'

    @carrier.save!


  end

  def self.get_all_carriers

    CarrierDetail.all

  end


  def self.carrier_params params
    params.require(:carrier_detail).permit(:email_id, :first_name, :last_name, :img_link, :phone)
  end

end
