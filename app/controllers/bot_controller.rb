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
        elsif text == "more" || text == "More ..."
          FacebookBot.new.send_generic_message(sender, choose_more)
        elsif text == "faq" || text == "FAQs"
          FacebookBot.new.send_generic_message(sender, choose_faq)
        elsif text == "lostcard" || text == "I lost my credit card"
          res = "Please call the Bank’s 24 hour customer service hotline immediately to report:
- For Platinum Card +95 137 0066
- For Classic Card  +95 137 0055"
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "whatiscard" || text == "What is Credit Card?"
          res = "Credit Card is a kind of unsecured personal loan provided through a “plastic card”, which can be used for payment of goods & services or cash withdrawal."
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "atecard" || text == "ATM ate my card."
          res = "Please call the Bank’s 24 hour customer service hotline immediately to report:
- (+95) 1-515216-18"
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "tempblock" || text == "Want to do temporary block."
          res = "Please call the Bank’s 24 hour customer service hotline immediately to report:
- (+95) 1-515216-18"
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "newchip" || text == "Want new chip card?"
          res = "At a chip-enabled terminal
- Instead of swiping, insert your card face up into the terminal
- Don’t take the card out until the transaction is complete
- Sign for your purchase or enter your PIN, if asked, and remove the card."
          res1 = "At a traditional terminal without chip technology
- Just swipe your card as you’ve done in the past
- Sign for your purchase."
          res2 = "If asked For phone or online purchases
- Complete your purchases just as you’ve done in the past."
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_text_message(sender, res1)
          FacebookBot.new.send_text_message(sender, res2)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "morefaq" || text == "More .."
          FacebookBot.new.send_generic_message(sender, choose_faq_more)
        elsif text == "ျပန္လည္ေရြးခ်ယ္မည္"
          FacebookBot.new.send_generic_message(sender, choose_again_support)
        elsif text == "ျပန္လည္ေရြးခ်ယ္မည္။"
          FacebookBot.new.send_generic_message(sender, choose_again)
        elsif text == "မေရြးခ်ယ္ေတာ့ပါ။"
          FacebookBot.new.send_generic_message(sender, generic)
        elsif text == "အစသုိ႔ျပန္သြားမည္။"
          choose_topic[:attachment][:payload].merge!(text: "သိရွိလုိသည့္ အေၾကာင္းအရာကုိ ျပန္လည္ေရြးခ်ယ္ပါ။")
          FacebookBot.new.send_generic_message(sender, choose_topic)
        elsif text == "မလုပ္ေဆာင္ေတာ့ပါ။"
          FacebookBot.new.send_generic_message(sender, generic)
        elsif text == "Bahan" || text == "bahan" || text == "ba han" || text == "Ba Han"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Bahan",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/KBZ+ATM,+U+Chit+Maung+Rd,+Yangon/@16.816299,96.0980961,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c1ecb385a272a3:0x133a3a299e9803da!2m2!1d96.1681366!2d16.8163109",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "Kamaryut" || text == "Kamayut" || text == "ka ma yut" || text == "ka mar yut" ||
          text == "kamaryut" || text == "kamayut"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Kamaryut",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/Kanbawza+Bank,+Kamaryut+Branch,+Yangon/@16.8325306,96.0623348,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c194b7f7af0dbd:0x920350f3e1dc3a1c!2m2!1d96.1323753!2d16.8325425",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "Sanchaung" || text == "sanchaung" || text == "san chaung" || text == "San Chaung"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Sanchaung",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/KBZ+ATM,+Hanthawaddy+Road,+Yangon/@16.8136185,96.0630624,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c1eb4995f06a93:0x78f819b245bd935b!2m2!1d96.1331029!2d16.8136304",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "Ahlone" || text == "ahlone" || text == "a lone" || text == "A lone" || text == "Ah Lone"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Ahlone",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/search/kbz+bank+in+Ahlone,+Yangon,+Yangon+Region/@16.771094,96.1512332,15z/data=!3m1!4b1",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "Dagon" || text == "dagon" || text == "da gon"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Dagon",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/KBZ+ATM,+Hanthawaddy+Road,+Yangon/@16.8136185,96.0630624,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c1eb4995f06a93:0x78f819b245bd935b!2m2!1d96.1331029!2d16.8136304",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "Tamwe" || text == "tarmwe" || text == "Tar Mwe" || text == "Tar Mway" || text == "tar mwe"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Tamwe",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/KBZ+ATM,+U+Chit+Maung+Rd,+Yangon/@16.816299,96.0980961,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c1ecb385a272a3:0x133a3a299e9803da!2m2!1d96.1681366!2d16.8163109",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "Pabedan" || text == "pabedan" || text == "Pa Be Dan" || text == "pa be dan"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Pabedan",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/KBZ+ATM,+U+Chit+Maung+Rd,+Yangon/@16.816299,96.0980961,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c1ecb385a272a3:0x133a3a299e9803da!2m2!1d96.1681366!2d16.8163109",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "Latha" || text == "Lathar" || text == "La Tha" || text == "La Thar" || text == "la thar" ||
          text == "la tha"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Latha",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/KBZ+ATM,+U+Chit+Maung+Rd,+Yangon/@16.816299,96.0980961,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c1ecb385a272a3:0x133a3a299e9803da!2m2!1d96.1681366!2d16.8163109",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "Hlaing" || text == "hlaing"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Hlaing",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/Kanbawza+Bank,+Kamaryut+Branch,+Yangon/@16.8325306,96.0623348,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c194b7f7af0dbd:0x920350f3e1dc3a1c!2m2!1d96.1323753!2d16.8325425",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support) 
        elsif text == "Lanmadaw" || text == "lanmadaw" || text == "lan ma daw" || text == "Lan Ma Daw"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ATM in Lanmadaw",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://www.google.com.mm/maps/dir/''/Kanbawza+Bank,+Kamaryut+Branch,+Yangon/@16.8325306,96.0623348,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x30c194b7f7af0dbd:0x920350f3e1dc3a1c!2m2!1d96.1323753!2d16.8325425",
                    "title":"View On Map",
                    "webview_height_ratio": "compact"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "call"
          FacebookBot.new.send_text_message(sender, "Please Dial '01-538075', '01-538076', '01-538078'")
          FacebookBot.new.send_generic_message(sender, back_support)
        elsif text == "atmlocation" || text == "ATM Locations"
          res = "ေအာက္ေဖာ္ျပပါ ၿမိဳ႔နယ္မ်ားအနက္မွ ရွာေဖြလုိေသာ ၿမိဳ႕နယ္၏အမည္အား ေဖာ္ျပပါအတုိင္း ရုိက္ထည့္ပါ။"
          mes = "- Ahlone
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
          FacebookBot.new.send_text_message(sender, mes)
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
          res = "ေဖာ္ျပပါႏွူန္းထားမ်ားမွာ 25.10.2016 တြင္ရရွိေသာ ႏွူန္းထားမ်ားျဖစ္ပါသည္။"
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, choose_currency)
          FacebookBot.new.send_generic_message(sender, back_support)
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
        "HELLO", "HI", "Hey", "hey", "HEY", "Hello Customer Service", "hello customer service", "hi customer service",
        "Hi Customer Service", "may sa yar shi lox"]
    end

    def choose_topic
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"မဂၤလာပါရွင္။ ယခုလုိဆက္သြယ္ျခင္းအတြက္ ေက်းဇူးတင္ရွိပါတယ္။ မည္သည့္အေၾကာင္းအရာအတြက္ သိရွိလုိပါသလဲ။",
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
                    "title":"More ...",
                    "payload":"more"
                  }
                ]
              }
            }
          }
    end

    def choose_faq
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"Frequently Asked Questions.",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"I lost my credit card",
                    "payload":"lostcard"
                  },
                  {
                    "type":"postback",
                    "title":"What is Credit Card?",
                    "payload":"whatiscard"
                  },
                  {
                    "type":"postback",
                    "title":"More ..",
                    "payload":"morefaq"
                  }
                ]
              }
            }
          }
    end

    def choose_faq_more
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"Frequently Asked Questions.",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"ATM ate my card.",
                    "payload":"atecard"
                  },
                  {
                    "type":"postback",
                    "title":"Want to do temporary block.",
                    "payload":"tempblock"
                  },
                  {
                    "type":"postback",
                    "title":"Want new chip card?",
                    "payload":"newchip"
                  }
                ]
              }
            }
          }
    end

    def choose_more
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"သိရွိလုိေသာအေၾကာင္းအရာကို ထပ္မံေရြးခ်ယ္ပါ။",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"Career",
                    "payload":"career"
                  },
                  {
                    "type":"postback",
                    "title":"FAQs",
                    "payload":"faq"
                  },
                  {
                    "type":"postback",
                    "title":"Contact",
                    "payload":"call"
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
      mes = {
              "attachment":{
              "type":"image",
              "payload":{
              "url":"http://kbbot.herokuapp.com/images/ce.jpg"
            }
          }
        }
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
                "text":"သိရွိလုိသည့္ အမ်ဴိးအစားကုိ ျပန္လည္ေရြးခ်ယ္ပါ။",
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
                    "title":"More ...",
                    "payload":"more"
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
                      "image_url": "http://kbbot.herokuapp.com/images/fbpp.jpg",
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

