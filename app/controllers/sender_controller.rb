class SenderController < ApplicationController

  require 'date'
  require_relative '../../app/models/user'
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  include SenderHelper

  include DeviseTokenAuth::Concerns::SetUserByToken

  #before_action :authenticate_user!


  def new
      logger.debug "in create new sender"
      email = request.headers['uid']
      p "email is #{email}"
      sender,code = SenderHelper.create_new_sender(params,request)
      respond_to do |format|

        #format.html #sender.html
        format.json { render :json => sender ,:status => code}

      end



  end

  def all

    respond_to do |format|

      all_senders = SenderHelper.get_all_senders
      #format.html  # index.html.erb
      format.json  { render :json => all_senders }
    end

  end

  def details

    details = SenderHelper.get_sender_details params[:id]

    respond_to do |format|

      format.json { render :json => details}

    end

  end

  def new_order
    logger.debug "in create new order for a sender"
    logger.debug params




    begin


      order,code = SenderHelper.new_order(params[:id], params)

    respond_to do |format|

      format.json { render :json => order ,:status=>code}

    end

    rescue Exception=>e
      render :json => e.message , :status=>404

      end

  end

  #handle_asynchronously :new_order

  def all_orders
    logger.debug "in get all active order"

    begin

      orders = SenderHelper.get_all_orders params[:id]
      respond_to do |format|
      format.json { render :json => orders ,:status=>200}
      end



    rescue Exception =>e
      error = {}
      error['error'] = e.message
      render :json => error ,:status=>400

    end

  end

   def update_reciever_details
      logger.debug "in save reciever details"

     begin
      sender_id = params[:sender_id]
      order_id = params[:order_id]

      reciever = SenderHelper.update_reciever_details sender_id,order_id,params

       respond_to do |format|
         format.json { render :json=>reciever , :status=>201}
       end

     rescue Exception=>e
       error = {}
       error['error'] = e.message
       render :json => error , :status=>400

     end
   end

    def edit_reciever_details

      logger.debug "in edit of reciever details"

      begin


      @updated_mapping = SenderHelper.edit_reciever_details params

        respond_to do |format|


          format.json { render :json => @updated_mapping ,:status => 204}
        end


      rescue Exception=>e
        error = {}
        error['error'] = e.message
        render :json => error , :status=>400

      end

    end

    def cancel_order
      logger.debug 'in cancel order'
      begin

        resp , code = SenderHelper.cancel_order(params)
        respond_to do |format|
          format.json { render :json => resp , :status=>code}
        end
      rescue Exception=>e
        error = {}
        error['error'] = e.message
        render :json => error , :status =>400

      end
    end

end
