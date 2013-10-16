module LayerVault
  class User < LayerVault::Model
    class << self
      def me
        resp = MultiJson.decode(LayerVault.client.me)
        new(resp)
      end
    end
  end
end