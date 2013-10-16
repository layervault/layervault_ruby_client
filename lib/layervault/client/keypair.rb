require 'multi_json'

module LayerVault
  class Client
    module Keypair
      def keypair
        get "keypair"
      end
    end
  end
end