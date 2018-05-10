require 'httparty'

url = "https://crix-api-endpoint.upbit.com/v1/crix/candles/minutes/1?code=CRIX.UPBIT.KRW-BTC"
price = HTTParty.get(url).body
target_price = JSON.parse(price)
real_price = target_price[0]['tradePrice']

puts real_price #현재가격

