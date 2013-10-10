module LayerVault
  class Client
    module Revisions
      def revision(organization_name, project_name, path, file_name, revision)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}"
      end

      def previews(organization_name, project_name, path, file_name, revision)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/previews"
      end

      def revisions(organization_name, project_name, path, file_name, revision)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/revisions"
      end

      def meta(organization_name, project_name, path, file_name, revision)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/meta"
      end
    end
  end
end