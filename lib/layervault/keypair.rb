module LayerVault
  class Keypair < LayerVault::Model
    class << self
      def fetch
        resp = MultiJson.decode(LayerVault.client.keypair)
        new(resp)
      end
    end
  end
end