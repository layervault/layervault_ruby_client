module LayerVault
  class Organization < LayerVault::Model
    class << self
      def for( organization )
        resp = MultiJson.decode(LayerVault.client.organization( organization ))
        build_association(resp, :projects)
      end
    end
  end
end