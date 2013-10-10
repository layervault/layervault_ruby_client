module LayerVault
  class Client
    module Folders
      def folder(organization_name, project_name, path)
        get "organizations/#{organization_name}/#{project_name}/#{path}"
      end
    end
  end
end