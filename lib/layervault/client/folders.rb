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

      def move_folder(organization_name, project_name, path, options={})
        raise ClientParamsError.new("You must specify the :to option for the destination folder.") unless options.fetch(:to, nil)
        post "organizations/#{organization_name}/#{project_name}/#{path}/move", options
      end

      def change_folder_color(organization_name, project_name, path, options={})
        raise ClientParamsError.new("You must specify the color option for the new color to apply to the folder.") unless options.fetch(:color, nil)

        put "organizations/#{organization_name}/#{project_name}/#{path}", options
      end
    end
  end
end