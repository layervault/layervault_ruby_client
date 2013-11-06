module LayerVault
  class Folder < LayerVault::Model
    class << self
      def for(organization, project, folder_path)
        resp = MultiJson.decode(LayerVault.client.folder(organization, project, folder_path))
        instance = build_associations(resp, :folders, :files)
        instance.set_context(organization: organization, project: project, folder_path: folder_path)
      end
    end

    def delete_file(file_name, md5)
      LayerVault.client.delete_file( context.organization, context.project_name, context.folder_path, file_name, md5: md5 )
    end

    def create_file(file_name, options={})
      LayerVault.client.create_file( context.organization, context.project_name, context.folder_path, file_name, options[:md5], options[:local_file_path], options[:content_type] )
    end

    def move_file(file_name, new_folder, new_filename)
      LayerVault.client.move_file( context.organization, context.project_name, context.folder_path, file_name, new_folder: new_folder, new_filename: new_filename)
    end

    def sync_check(file_name, options={})
      LayerVault.client.sync_check( context.organization, context.project_name, context.folder_path, file_name, md5: options[:md5] )
    end
  end
end