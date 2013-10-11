module LayerVault
  class Client
    module Files
      def file(organization_name, project_name, path, file_name)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}"
      end

      def delete_file(organization_name, project_name, path, file_name)
        delete "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}"
      end

      def create_file(organization_name, project_name, path, file_name)
        post "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}"
      end

      def move_file(organization_name, project_name, path, file_name, new_folder, new_filename)
        post "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/move", new_folder: new_folder, new_filename: new_filename
      end

      def sync_check(organization_name, project_name, path, file_name, options={})
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/sync_check", options
      end
    end
  end
end