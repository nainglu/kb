class BotController < ApplicationController

  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def webhook
    if params["hub.verify_token"] == "my_voice_is_my_voice_verify_me"
      render json: params["hub.challenge"]
    end
    unless params["entry"].nil? || params["entry"].empty?
      
      sender = params["entry"][0]["messaging"][0]["sender"]["id"]
      unless params["entry"][0]["messaging"][0]["message"].nil?
        text = params["entry"][0]["messaging"][0]["message"]["text"]
      else
        unless params["entry"][0]["messaging"][0]["postback"].nil?
          text = params["entry"][0]["messaging"][0]["postback"]["payload"]
        else
          text = "aaa"
        end
      end
      unless text == "aaa"
        if greeting.include? text
          FacebookBot.new.send_generic_message(sender, choose_topic)
        elsif text == "atmservice" || text == "ATM Services"
          FacebookBot.new.send_generic_message(sender, choose_atm_topic)
        elsif text == "ျပန္လည္ေရြးခ်ယ္မည္"
          FacebookBot.new.send_generic_message(sender, choose_again_support)
        elsif text == "ျပန္လည္ေရြးခ်ယ္မည္။"
          FacebookBot.new.send_generic_message(sender, choose_again)
        elsif text == "မေရြးခ်ယ္ေတာ့ပါ။"
          FacebookBot.new.send_generic_message(sender, generic)
        elsif text == "အစသုိ႔ျပန္သြားမည္။"
          choose_topic[:attachment][:payload].merge!(text: "သိရွိလုိသည့္ အေၾကာင္းအရာကုိ ျပန္လည္ေရြးခ်ယ္ပါ။")
          FacebookBot.new.send_generic_message(sender, choose_topic)
        elsif text == "မလုပ္ေဆာင္ေတာ့ပါ။"
          FacebookBot.new.send_generic_message(sender, generic)
        elsif text == "call"
          FacebookBot.new.send_text_message(sender, "Please Dial '01-538075', '01-538076', '01-538078'")
        elsif text == "atmlocation" || text == "ATM Locations"
          res = "ေအာက္ေဖာ္ျပပါ ၿမိဳ႔နယ္မ်ားအနက္မွ ရွာေဖြလုိေသာ ၿမိဳ႕နယ္၏အမည္အား ေဖာ္ျပပါအတုိင္း ရုိက္ထည့္ပါ။"
          res1 = "
          - Ahlone
          - Bahan
          - Dagon
          - Sanchaung
          - Tamwe
          - Pabedan
          - Hlaing
          - Latha
          - Kamaryut
          - Lanmadaw"
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_text_message(sender, res1)
        elsif text == "cardinfo" || text == "Card Informations"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"Card Informations",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.kbzbank.com/en/cards/",
                    "title":"View Informations",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "exchange" || text == "Currency Exchange"
          FacebookBot.new.send_text_message(sender, choose_currency)
        elsif text == "career" || text == "Career"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"Careers",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.kbzbank.com/en/about-us/careers/",
                    "title":"View Careers",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        else
          res = "သင္၏ေျပာၾကားခ်က္ကုိ auto reply မွနားမလည္ပါ။"
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, back_support)
        end
      end
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end

  private
    def greeting
      ["မဂၤလာပါ", "ဟုိင္း", "Hi", "hi", "Hello", "hello", 
        "HELLO", "HI", "Hey", "hey", "HEY"]
    end

    def choose_topic
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"မဂၤလာပါရွင္။ ယခုလုိဆက္သြယ္ျခင္းအတြက္ ေက်းဇူးတင္ရွိပါတယ္။ မည္သည့္အေၾကာင္းအရာအတြက္ သိရွိလုိပါသလဲ။",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"ATM Services",
                    "payload":"atmservice"
                  },
                  {
                    "type":"postback",
                    "title":"Currency Exchange",
                    "payload":"exchange"
                  },
                  {
                    "type":"postback",
                    "title":"Career",
                    "payload":"career"
                  }
                ]
              }
            }
          }
    end

    def back_support
      mes = {
          "text": "ဆက္လက္လုပ္ေဆာင္ရန္",
          "quick_replies":[
            {
              "content_type":"text",
              "title":"ျပန္လည္ေရြးခ်ယ္မည္။",
              "payload":"ျပန္လည္ေရြးခ်ယ္မည္။"
            },
            {
              "content_type":"text",
              "title":"မလုပ္ေဆာင္ေတာ့ပါ။",
              "payload":"မလုပ္ေဆာင္ေတာ့ပါ။"
            }
          ]
        }
    end

    def choose_atm_topic
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"အေသးစိတ္ကုိထပ္မံ ေရြးခ်ယ္ပါ။",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"ATM Locations",
                    "payload":"atmlocation"
                  },
                  {
                    "type":"postback",
                    "title":"Card Informations",
                    "payload":"cardinfo"
                  }
                ]
              }
            }
          }
    end

    def choose_currency
      mes = "
      
      _USD_
      BUY 1285 - SELL 1290,
      _SGD_
      BUY 915 - SELL 925,
      _EUR_
      BUY 1380 - SELL 1402,
      _BAHT_
      BUY 36.2 - SELL 36.8"
    end

    def choose_again_quick
      mes = {
          "text":"အမ်ိဴးအစား ျပန္လည္ေရြးခ်ယ္လုိပါသလား။",
          "quick_replies":[
            {
              "content_type":"text",
              "title":"ျပန္လည္ေရြးခ်ယ္မည္",
              "payload":"ျပန္လည္ေရြးခ်ယ္မည္"
            },
            {
              "content_type":"text",
              "title":"မေရြးခ်ယ္ေတာ့ပါ။",
              "payload":"မေရြးခ်ယ္ေတာ့ပါ။"
            }
          ]
        }
    end

    
    def choose_again
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"သိရွိလုိသည့္ အမ်ဴိးအစားကုိ ျပန္လည္ေရြးခ်ယ္ပါ။",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"ATM Services",
                    "payload":"atmservice"
                  },
                  {
                    "type":"postback",
                    "title":"Currency Exchange",
                    "payload":"exchange"
                  },
                  {
                    "type":"postback",
                    "title":"Career",
                    "payload":"career"
                  }
                ]
              }
            }
          }
    end

   
    def generic
      mes = {
              "attachment":{
                "type":"template",
                "payload":{
                  "template_type":"generic",
                  "elements":[
                    {
                      "title":"KBZ Bank",
                      "subtitle":"ယခုလုိေမးျမန္းျခင္းအတြက္ ေက်းဇူးအထူးတင္ရွိပါသည္။",
                      "buttons":[
                        {
                          "type":"postback",
                          "title":"ဖုန္းေခၚဆုိမည္",
                          "payload":"call"
                        },
                        {
                          "type":"postback",
                          "title":"ထပ္မံေမးျမန္းမည္",
                          "payload":"hi"
                        }              
                      ]
                    }
                  ]
                }
              }
            }
    end

    def welcome_msg
      mes = {
        "text": "Welcome! Say Hi"
      }
    end

    def continue
      mes = {
          "text":"လူႀကီးမင္း၏ ေမးျမန္းခ်က္ကုိနားမလည္ပါရွင္။ ဆက္လက္လုပ္ေဆာင္လုိပါသလား။",
          "quick_replies":[
            {
              "content_type":"text",
              "title":"လုပ္ေဆာင္မည္။",
              "payload":"လုပ္ေဆာင္မည္။"
            },
            {
              "content_type":"text",
              "title":"မလုပ္ေဆာင္ေတာ့ပါ။",
              "payload":"မလုပ္ေဆာင္ေတာ့ပါ။"
            }
          ]
        }
    end

    def back_email
      mes = {
          "text": "ဆက္လက္လုပ္ေဆာင္ရန္",
          "quick_replies":[
            {
              "content_type":"text",
              "title":"ျပန္လည္ေရြးခ်ယ္မည္၊",
              "payload":"ျပန္လည္ေရြးခ်ယ္မည္၊"
            },
            {
              "content_type":"text",
              "title":"မလုပ္ေဆာင္ေတာ့ပါ။",
              "payload":"မလုပ္ေဆာင္ေတာ့ပါ။"
            }
          ]
        }
    end
end

