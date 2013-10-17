module LayerVault
  class Organization < LayerVault::Model
    class << self
      def for( organization )
        resp = MultiJson.decode(LayerVault.client.organization( organization ))
        instance = build_associations(resp, :projects)
        instance.set_context(organization: organization)
      end
    end
  end
end