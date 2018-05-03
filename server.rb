# encoding: UFT-8

require 'sinatra'
require './block'

blockchain = BlockChain.new

get '/' do 
	message = "<center>"

	blockchain.all_chains.each do |eachBlock|
		message << "BlockHeight"	   : " + eachBlock['nHeight'].to_s + "<br>"
		message << "Time"			   : " + eachBlock['nTime'].to_s + "<br>"
		message << "Nonce"			   : " + eachBlock['nNonce'].to_s + "<br>"
		message << "Previous_BlockHash : " + eachBlock['previous_address'].to_s + "<br>"
		message << "Cur_BlockHash	   : " + Digest::SHA256.hexdigest(eachBlock.to_s) + "<br>"
		message << "Cur_Transation	   : " + eachBlock['Transaction'].to_s + "<br>"
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

get 'wallet_list' do
	blockchain.show_all_wallet.to_s
end



