 require 'digest'
 require 'securerandom'
 require 'httparty'
 require 'json'

 class Blockchain

 	def initialize
 		@chain = []
 		@transaction = []
 		@wallet = {}
 		@node = []
 	end

 	def make_a_wallet
 	    address = SecureRandom.uuid.gsub("-", "")
 	    @wallet[address] = 100
 	    @wallet
 	end

 	def wallet_list
 		@wallet
 	end

 	def make_a_trans(sender, recv, amount)

 		if 		@wallet[sender].nil?
 				"보내는 주소가 잘못되었습니다."
 		elsif 	@wallet[recv].nil?
 				"받는 주소가 잘못되었습니다."
 		elsif   @wallet[sender].to_f < amount.to_f
 			    "돈이 부족합니다." 
 		else
 				@wallet[sender]   = @wallet[sender].to_f - amount.to_f
 				@wallet[recv] = @wallet[recv].to_f + amount.to_f

 		trans = {
 				"sender" => sender,
 				"recv"   => receiver,
 				"amount" => amount
 				}
 		@transaction << trans
 				"다음 블록에 쓰여집니다." + (@chain.length + 1).to_s
 		end
    end

    def mining

    	begin
        		nonce  = rand(1000000)
				hashed = Digest::SHA256.hexdigest(nonce.to_s)
		end while hashed[0..3] != "0000"
		nonce

		last_block = @chain[-1]
		
		block = {
				"index" 			=> @chain.size + 1,
				"Time"	  			=> Time.now.to_i,
				"nonce"  			=> nonce,
				"previous_address" 	=> Digest::SHA256.hexdigest(last_block.to_s),
				"transaction"		=> @transaction 
				}		         		
		@transaction =[]
		@chain << block
		
	end

	def all_blocks
		@chain
	end

	def ask_block
		@node.each do |n|
			n_block = HTTParty.get("http://localhost:" + n + "/number_of_blocks").body

			if @chain.length < n_block.to_i
				json_chain = @chain.to_json
				full_chain = HTTParty.get("http://localhost:" + n + "/recv_chain?chain=" + json_chain)
				@chain = JSON.parse(full_chain)
			end
		end		
	end

	def add_block(block)
		block.each do |b|
			@chain << b
		end
		@chain.to_json
	end
	
	def all_node
		@node
	end
end				

