require 'telegram/bot'
require 'httparty'

token = '내주소다'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when 'hello'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when 'price'

    	url = "https://crix-api-endpoint.upbit.com/v1/crix/candles/minutes/1?code=CRIX.UPBIT.KRW-BTC"
		price = HTTParty.get(url).body
		target_price = JSON.parse(price)
		real_price = target_price[0]['tradePrice']
    	
    	url = "https://crix-api-endpoint.upbit.com/v1/crix/candles/minutes/1?code=CRIX.UPBIT.USDT-BTC"
    	price = HTTParty.get(url).body
		target_price = JSON.parse(price)
		real_price_usdt = target_price[0]['tradePrice']

    	url = "https://api.fixer.io/latest?base=USD"
		rate = HTTParty.get(url).body
		parsed_rate = JSON.parse(rate)
		target_rate = parsed_rate["rates"]["KRW"].to_i

	   msg = ""
	   msg << (real_price/10000).round(0).to_s + "man won\n"
	   msg << "$" + (real_price_usdt).round(0).to_s + "\n"
	   msg << ((real_price / (real_price_usdt * target_rate) - 1) * 100).round(2).to_s + "%"

    	
       bot.api.send_message(chat_id: message.chat.id, text: msg) 
   end
	end
end