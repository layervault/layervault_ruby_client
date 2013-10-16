require 'multi_json'

module LayerVault
  class Client
    module Keypair
      def keypair
        resp = MultiJson.decode(get "keypair")
        LayerVault::Keypair.new(resp)
      end
    end
  end
end