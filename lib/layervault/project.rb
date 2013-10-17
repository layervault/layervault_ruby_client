module LayerVault
  class Project < LayerVault::Model
    class << self
      def for(organization, project)
        resp = MultiJson.decode(LayerVault.client.project(organization, project))
        build_associations(resp, :folders, :files)
        instance.set_context(organization: organization, project:project)
      end
    end
  end
end