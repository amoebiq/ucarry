class PushNotifyService

  @APP_NAME = 'KarrierBay'

  def initialize(params)

    @params = params

  end


  def send_to_specific_mobile(tokens , title , body )

    p 'in send to specific mobile service'
    api_key = ENV['fcm_api_key']

    begin



    fcm = FCM.new(api_key)
    options = {}
    options[:notification] = {}
    options[:notification][:title] = title
    options[:notification][:body] = body
    #options[:notification][:tag] = tag
    # options[:notification][:sound] = sound unless sound == 'none'
    # options[:notification][:icon] = icon
    # options[:notification][:color] = color
    options[:content_available] = true
    options[:data] = {}
    options[:data][:type] = @params[:data_type] if @params[:data_type]!=nil
    p @params[:data_title]
    options[:data][:title] = @params[:data_title] if @params[:data_title]!=nil
    options[:data][:body] = @params[:data_body] if @params[:data_body]!=nil
    options[:data][:image_url] = @params[:data_image_url] if @params[:data_image_url]!=nil
    options[:data][:url] = @params[:data_url] if @params[:data_url]!=nil

    responses = []
    tokens.compact.each_slice(1000) do |tokens_sliced|
      response = fcm.send(tokens_sliced, options)
      responses << response
    end
    return responses.to_json

    rescue Exception=>e

    end

  end


end