class FacebookBot

  def send_message(data)
    url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=EAAQf6oTQBAGzqyqiZCqFWQ6m5M8MzkZBPgI6eD6ebhBpGNEmsDbhOOnsgxZCvBdfY2PviXi3zMtAfDoifsQZB31mePl1oZC1tuvd4x4Wvk86mq3dA0v61eVJxRhqnCLoyoixZCuZB8oA7BLk7rse75x5NZClRhZAZB9iZBhpCpOo0gZDZD")

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