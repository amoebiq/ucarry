class SenderController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  include SenderHelper



  def new
      logger.debug "in create new sender"
      sender = SenderHelper.create_new_sender params
      respond_to do |format|

        #format.html #sender.html
        format.json { render :json => sender}

      end



  end

  def all

    respond_to do |format|

      all_senders = SenderHelper.get_all_senders
      #format.html  # index.html.erb
      format.json  { render :json => all_senders }
    end

  end

end
