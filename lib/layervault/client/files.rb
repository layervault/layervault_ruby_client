module LayerVault
  class Client
    module Files
      def file(organization_name, project_name, path, file_name)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}"
      end

      def delete_file(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the md5 option of the file you are trying to delete.") unless options.fetch(:md5, nil)
        delete "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}", options
      end

      def create_file(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the MD5 option for the file you want to create.") unless options.fetch(:md5, nil)
        raise ClientParamsError.new("You must specify the file_data or remote_url options for the file you want to create.") if (options.fetch(:file_data, nil) && options.fetch(:remote_url, nil))
        put "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}", options
      end

      def move_file(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the new_folder option to specify the destination folder") unless options.fetch(:new_folder, nil)
        raise ClientParamsError.new("You must specify the new_filename option to specify the destination folder") unless options.fetch(:new_file_name, nil)

        post "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/move", options
      end

      def sync_check(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the md5 option of the file you are trying to sync check.") unless options.fetch(:md5, nil)
        get "organizations/#{organization_name}/#{project_name}/#{path}/#{file_name}/sync_check", options
      end
    end
  end
end