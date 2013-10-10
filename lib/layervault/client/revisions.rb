module LayerVault
  class Client
    module Revisions
      def revision(organization_name, project_name, path, file_name, revision)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}"
      end
    end
  end
end