module LayerVault
  class Client
    module Projects
      def project(organization_name, project_name)
        get "#{organization_name}/#{project_name}"
      end

      def create_project(organization_name, project_name)
        post "#{organization_name}/#{project_name}"
      end

      def delete_project(organization_name, project_name)
        delete "#{organization_name}/#{project_name}"
      end
    end
  end
end