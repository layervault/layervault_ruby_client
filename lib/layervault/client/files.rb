module LayerVault
  class Client
    module Files
      def file(organization_name, project_name, path, file_name)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}"
      end
    end
  end
end