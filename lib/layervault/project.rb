module LayerVault
  class Project < LayerVault::Model

    class << self
      def for(organization, project)
        resp = MultiJson.decode(LayerVault.client.project(organization, project))
        build_associations(resp, :folders, :files)
        instance.set_context(organization: organization, project:project)
      end
    end

    def create_folder(folder_name)
      LayerVault.client.create_folder( context.organization, context.project_name, folder_name )
    end

    def delete_folder(folder_name)
      LayerVault.client.delete_folder( context.organization, context.project_name, folder_name )
    end

    def move_folder(folder_name, destination_name)
      LayerVault.client.move_folder( context.organization, context.project_name, folder_name, to: destination_name )
    end

    def change_folder_color(folder_name, destination_name, color)
      LayerVault.client.change_folder_color( context.organization, context.project_name, folder_name, color: color )
    end
  end
end