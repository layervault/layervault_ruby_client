module LayerVault
  class Client
    module Projects
      def project(organization_name, project_name)
        get "organizations/#{organization_name}/#{project_name}"
      end

      def create_project(organization_name, project_name)
        post "organizations/#{organization_name}/#{project_name}"
      end
    end
  end
end