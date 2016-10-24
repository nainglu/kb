class FacebookBot

  def send_message(data)
    url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=EAAYfjpzeZAE8BAHmCRNNnEn97hqBJl7qXF7ig74bUmSdmpxopnBbtuotenXIzwwocPucu6t0Sz5ZCsFyV6lv5txZAFTboQ8KAjdv3wWCievZCWHORUIZCyp4fnk0KYE647DFWKuQe899TubeeI1R7ZANIBPPwNWLb3Q55tgH2fNgZDZD")

    http = Net::HTTP.new(url.host, 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE #only for development.
    begin
      request = Net::HTTP::Post.new(url.request_uri)
      request["Content-Type"] = "application/json"
      request.body = data.to_json
      response = http.request(request)
      body = JSON(response.body)
      return { ret: body["error"].nil?, body: body }
    rescue => e
      raise e
    end
  end

  def send_text_message(sender, text)
    data = {
      recipient: { id: sender },
      message: { text: text }
    }
    send_message(data)
  end

  def send_generic_message(sender, mes)
    data = {
      recipient: { id: sender },
      message: mes
    }
    send_message(data)
  end

  def call_to_action(sender, mes)
    data = {
      recipient: { id: sender},
      "setting_type":"call_to_actions",
      "thread_state":"new_thread",
      "call_to_actions":[
        {
          "message": mes
        }
      ]
    }
    send_message(data)
  end

  
end