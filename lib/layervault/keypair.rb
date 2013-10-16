require 'hashie'

module LayerVault
  class Keypair < Hashie::Mash
    class << self
      def fetch
        resp = MultiJson.decode(LayerVault.client.keypair)
        new(resp)
      end
    end
  end
end