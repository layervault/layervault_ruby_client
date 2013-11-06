module LayerVault
  class User < LayerVault::Model
    class << self
      def me
        resp = MultiJson.decode(LayerVault.client.me)
        instance = build_associations(resp, :organizations, :projects)
        instance
      end
    end
  end
end