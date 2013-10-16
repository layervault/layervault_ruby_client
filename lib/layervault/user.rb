require 'hashie'

module LayerVault
  class User < Hashie::Mash
    class << self
      def me
        resp = MultiJson.decode(LayerVault.client.me)
        new(resp)
      end
    end
  end
end