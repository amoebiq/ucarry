class PaymentsService

  require 'faraday'


  def initialize(params)

    @params = params

  end

  def generate_payments



    api = Instamojo::API.new("e222f49c1714e326bf33468c3f7eee47", "dd4737b45c3fe9c25be606eb707e2f14")
    p "Client is #{api}"
    client = api.client

    new_link = client.create_link do |link|
      link.title = 'API product v1.1'
      link.description = 'Dummy offer via API'
      link.currency = 'INR'
      link.base_price = 0
      link.quantity = 10
      link.redirect_url = 'http://crowdcarry.com'

    end


    return new_link,200

  end

  def faraday_generate_payments user , amount

    headers = {"X-Api-Key" => "e222f49c1714e326bf33468c3f7eee47", "X-Auth-Token" => "dd4737b45c3fe9c25be606eb707e2f14"}

    payload = {
        purpose: 'CrowdCarry Sending Charge',
        amount: amount,
        buyer_name: user[:name],
        email: user[:email],
        phone: user[:phone],
        redirect_url: 'http://www.crowdcarry.com/redirect/',
        send_email: true,
        send_sms: true,
        webhook: 'http://www.example.com/webhook/',
        allow_repeated_payments: false,
    }


    conn = Faraday.new(:url => 'https://www.instamojo.com/api/1.1/', :headers => headers)
    response = conn.post 'payment-requests/', payload
    return  response.body , 200

  end

end