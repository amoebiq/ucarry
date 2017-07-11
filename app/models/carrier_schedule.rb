class CarrierSchedule < ActiveRecord::Base




  has_one :carrier_schedule_detail , foreign_key: 'schedule_id' , autosave: true ,primary_key: 'schedule_id'
  has_one :user , foreign_key: 'uid' , primary_key: 'carrier_id'
  accepts_nested_attributes_for :carrier_schedule_detail
  has_many :rating, :foreign_key => 'user' , :autosave => true , :primary_key => 'carrier_id'




  default_scope { order(updated_at: :desc) }


  def self.filter_by_params(params)
    scoped = self.scoped
    scoped = scoped.where(:from_loc => params[:from_loc]) if params[:from_loc]
    scoped = scoped.where(:to_loc => params[:to_loc]) if params[:to_loc]
    scoped
  end

  scope :from_loc, -> (from_loc) { where from_loc: from_loc}

  scope :to_loc, -> (to_loc) { where to_loc: to_loc}





end
