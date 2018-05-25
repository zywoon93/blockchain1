# encoding: UTF-8

require 'sinatra'
require './block'

set :bind, '0.0.0.0'

blockchain = Blockchain.new

get '/' do 
	message = "<center>"

	blockchain.all_blocks.each do |b|
		message << "Number	   		: " + b['index'].to_s + "<br>"
		message << "Time		   	: " + b['Time'].to_s + "<br>"
		message << "Nonce		   	: " + b['nonce'].to_s + "<br>"
		message << "Previous_Address: " + b['previous_address'].to_s + "<br>"
		message << "My-Address	  	: " + Digest::SHA256.hexdigest(b.to_s) + "<br>"
		message << "Transations	    : " + b['transaction'].to_s + "<br>"
		message << "<hr>"
	end

	message + "</center>"
	message
end

get '/mine' do
	blockchain.mining.to_s
end

get '/trans' do
	blockchain.make_a_trans(params["sender"], params["recv"], params["amount"])
end

get '/new_wallet' do 
    blockchain.make_a_wallet.to_s	
end

get '/all_wallet' do
 	blockchain.show_all_wallet.to_s
end	

get '/wallet_list' do
  blockchain.wallet_list.to_s
end

get '/number_of_blocks' do #블럭의 갯수
  blockchain.all_chains.size.to_s
end

get '/ask' do
  blockchain.ask_block.to_s
end  

get '/add_node' do
  port = params["port"]
  blockchain.add_port(port)
end

get '/all_node' do
  blockchain.all_node.to_s
end

get '/recv_chain' do
  recv_chain = params["chain"]
  extracted = JSON.parse(recv_chain)
  blockchain.add_block(extracted)
end  
  

 

#http://localhost:4567/trans?sender=a&recv=b&amount=1.1 
#주                  소/trans?sender=보내는 사람 지갑주소&recv=받는 사람지갑주소&amount=보내는 양
