module LayerVault
  class Client
    module Folders
      def folder(organization_name, project_name, path)
        get "organizations/#{organization_name}/#{project_name}/#{path}"
      end

      def delete_folder(organization_name, project_name, path)
        delete "organizations/#{organization_name}/#{project_name}/#{path}"
      end

      def create_folder(organization_name, project_name, path)
        post "organizations/#{organization_name}/#{project_name}/#{path}"
      end

      def move_folder(organization_name, project_name, path, destination_path)
        post "organizations/#{organization_name}/#{project_name}/#{path}/move", to: destination_path
      end

      def change_folder_color(organization_name, project_name, path, color)
        put "organizations/#{organization_name}/#{project_name}/#{path}", color: color
      end
    end
  end
end