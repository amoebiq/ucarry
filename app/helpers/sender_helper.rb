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


  def self.carrier_params params
    params.require(:sender_detail).permit(:email_id, :first_name, :last_name, :img_link, :phone)
  end

  def self.carrier_params_details params
    params.require(:sender_detail).permit(:email_id,:img_link, :phone)
  end


end
