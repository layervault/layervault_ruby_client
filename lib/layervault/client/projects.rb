require 'multi_json'

module LayerVault
  class Client
    module Projects
      def project(organization_name, project_name)
        resp = MultiJson.decode(get "organizations/#{organization_name}/#{project_name}")
        Project.new(resp)
      end

      def create_project(organization_name, project_name)
        post "organizations/#{organization_name}/#{project_name}"
      end

      def delete_project(organization_name, project_name)
        delete "organizations/#{organization_name}/#{project_name}"
      end
    end
  end
end