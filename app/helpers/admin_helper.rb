module AdminHelper

  def self.update_volumetric params
    ActiveRecord::Base.transaction do

        @vol = Volumetric.find_by_id(1)
        @vol.coefficient = params[:coefficient]
        @vol.save!


    end

    @vol
  end

  def self.get_volumetric

    @vol = Volumetric.find_by_id(1)
    @vol

  end

  def self.reciever_params params

    params.require(:volumetric).permit(:coefficient,:comments)

  end

end
