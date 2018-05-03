 require 'digest'
 require 'securerandom'

 class BlockHeader

 	def initialize
 		@time
 		@prevBlockHash
 		@nonce
 		@height
 	end

 	def prevBlockInfo
 	end

 end

 class Blockchain

 	def initialize
 		@chain = []
 		@transaction = []
 		@wallet = {}
 	end

 	def make_a_wallet
 	    address = SecureRandom.uuid.gsub("-", "")
 	    @wallet[address] = 100
 	    @wallet
 	end

 	def wallet_list
 		@wallet
 	end

 	def make_a_trans(sender, receiver, amount)
 		if 		@wallet[sender].nil?
 				"보내는 주소가 잘못되었습니다."
 		elsif 	@wallet[reciever].nil?
 				"받는 주소가 잘못되었습니다."
 		elsif   @wallet[sender].to_f < amount.to_f
 			    "돈이 부족합니다." 
 		else
 				@wallet[sender]   = @wallet[sender].to_f - amount.to_f
 				@wallet[receiver] = @wallet[receiver].to_f + amount.to_f

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
		block = {
				"nHeight" 			=> @chain.size,
				"nTime"	  			=> Time.now.to_i,
				"nNonce"  			=> nonce,
				"previous_address" 	=> Digest::SHA256.hexdigest(last_block.to_s),
				"Transaction"		=> @transaction 
				}		         		
		@transaction =[]
		@chain << block
		end
	end
	
	def last_block
		@chain[-1]
	end

	def all_chains
		@chain
	end
end

