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
        elsif text == "atmservice"
          FacebookBot.new.send_generic_message(sender, choose_atm_topic)
        elsif text == "ျပန္လည္ေရြးခ်ယ္မည္"
          FacebookBot.new.send_generic_message(sender, choose_again)
        elsif text == "ျပန္လည္ေရြးခ်ယ္မည္။"
          FacebookBot.new.send_generic_message(sender, choose_again_support)
        elsif text == "မေရြးခ်ယ္ေတာ့ပါ။"
          FacebookBot.new.send_generic_message(sender, generic)
        elsif text == "အစသုိ႔ျပန္သြားမည္။"
          choose_topic[:attachment][:payload].merge!(text: "သိရွိလုိသည့္ အေၾကာင္းအရာကုိ ျပန္လည္ေရြးခ်ယ္ပါ။")
          FacebookBot.new.send_generic_message(sender, choose_topic)
        elsif text == "မလုပ္ေဆာင္ေတာ့ပါ။"
          FacebookBot.new.send_generic_message(sender, generic)
        elsif text == "call"
          FacebookBot.new.send_text_message(sender, "Please Dial '09 2649 83474'")
        elsif text == "atmlocation"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM ရွိေသာေနရာမ်ား",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.kbzbank.com/en/ways-to-bank/atm-banking/",
                    "title":"View Locations",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
        elsif text == "Standard"
          res = "Standard Package"
          mes = {
            "attachment":{
              "type":"image",
              "payload":{
                "url":"https://webfactorymm.com/bots/files/web_pack_standard.jpg"
              }
            }
          }
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, choose_again_quick)
        elsif text == "Premium"
          res = "Premium Package"
          mes = {
            "attachment":{
              "type":"image",
              "payload":{
                "url":"https://webfactorymm.com/bots/files/web_pack_premium.jpg"
              }
            }
          }
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, choose_again_quick)
        elsif text == "exchange"
          FacebookBot.new.send_text_message(sender, choose_currency)
        elsif text == "support_gold"
          res = "Gold Plan"
          mes = {
            "attachment":{
              "type":"image",
              "payload":{
                "url":"https://webfactorymm.com/bots/files/support_gold.jpg"
              }
            }
          }
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "support_plat"
          res = "Platinum Plan"
          mes = {
            "attachment":{
              "type":"image",
              "payload":{
                "url":"https://webfactorymm.com/bots/files/support_paltinum.jpg"
              }
            }
          }
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "support_dia"
          res = "Diamond Plan"
          mes = {
            "attachment":{
              "type":"image",
              "payload":{
                "url":"https://webfactorymm.com/bots/files/support_diamond.jpg"
              }
            }
          }
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "emailreg" || text == "ျပန္လည္ေရြးခ်ယ္မည္၊"
          FacebookBot.new.send_generic_message(sender, choose_email_quick)
        elsif text == "Google"
          res = "Google Mail"
          mes = {
            "attachment":{
              "type":"image",
              "payload":{
                "url":"https://webfactorymm.com/bots/files/email_google.jpg"
              }
            }
          }
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_email)
        elsif text == "Rackspace"
          res = "Rackspace Mail"
          mes = {
            "attachment":{
              "type":"image",
              "payload":{
                "url":"https://webfactorymm.com/bots/files/email_rack.jpg"
              }
            }
          }
          
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_email)
        else
          t = params["entry"][0]["messaging"][0]
          FacebookBot.new.send_text_message(sender, t)
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
                    "title":"Card Information",
                    "payload":"cardinfo"
                  }
                ]
              }
            }
          }
    end

    def choose_currency
      mes = "*_USD_* *BUY 1285 SELL 1290*
             *_SGD_* *BUY 915 SELL 925*,
             EUR => BUY 1380 SELL 1402,
             BAHT=> BUY 36.2 SELL 36.8"
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

    def choose_email_quick
      mes = {
          "text":"ဝန္ေဆာင္မႈေပးသည့္ ကုမၸဏီေရြးခ်ယ္ပါ။",
          "quick_replies":[
            {
              "content_type":"text",
              "title":"Google",
              "payload":"google"
            },
            {
              "content_type":"text",
              "title":"Rackspace",
              "payload":"rack"
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
                    "title":"Basic",
                    "payload":"Basic"
                  },
                  {
                    "type":"postback",
                    "title":"Standard",
                    "payload":"Standard"
                  },
                  {
                    "type":"postback",
                    "title":"Premium",
                    "payload":"Premium"
                  }
                ]
              }
            }
          }
    end

    def choose_again_support
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"သိရွိလုိသည့္ အမ်ဴိးအစားကုိ ျပန္လည္ေရြးခ်ယ္ပါ။",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"Gold",
                    "payload":"support_gold"
                  },
                  {
                    "type":"postback",
                    "title":"Platinum",
                    "payload":"support_plat"
                  },
                  {
                    "type":"postback",
                    "title":"Diamond",
                    "payload":"support_dia"
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
                      "title":"Web Factory",
                      "image_url":"https://webfactorymm.com/bots/files/webfactory.jpg",
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

