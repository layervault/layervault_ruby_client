module LayerVault
  class Client
    module Projects
      def project(organization_name, project_name)
        get "#{organization_name}/#{project_name}"
      end

      def create_project(organization_name, project_name)
        post "#{organization_name}/#{project_name}"
      end

      def delete_project(organization_name, project_name)
        delete "#{organization_name}/#{project_name}"
      end

      def move_project(organization_name, project_name, options={})
        post "#{organization_name}/#{project_name}/move", options
      end

      def change_project_folder_color(organization_name, project_name, options={})
        put "#{organization_name}/#{project_name}", options
      end
    end
  end
end