module LayerVault
  class Organization < LayerVault::Model
    class << self
      def for( organization )
        resp = MultiJson.decode(LayerVault.client.organization( organization ))
        instance = build_associations(resp, :projects)
        instance.set_context(organization: organization)
      end
    end

    def create_project(project_name)
      LayerVault.client.create_project( context.organization, project_name )
    end

    def delete_project(project_name)
      LayerVault.client.create_project( context.organization, project_name )
    end
  end
end