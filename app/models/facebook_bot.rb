class FacebookBot

  def send_message(data)
    url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=EAAQVNDf6oTQBAMArhApSeAPcM8pjFCNWlujlCySZAyFKZAR4Gr5JGfZAG4NH8JlSpVJ5LwWVKeABDTfoJzVkm9vueDd4ZCyIfCdhOSebcxZCj93aTSPLql4IrhpnPwPtR9CpqRcCww0vQyYG8TZCsZC10o8A5jC35v36WxYXbQuZBgZDZD")

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