module LayerVault
  class Client
    module Revisions
      def revision(organization_name, project_name, path, file_name, revision)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}"
      end

      def preview(organization_name, project_name, path, file_name, revision, options={})
        raise ClientParamsError.new("You must specify the :w (width) and :h (height) options for the previews.") unless options.fetch(:w, nil) && options.fetch(:h, nil)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/preview", options
      end

      def meta(organization_name, project_name, path, file_name, revision)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/meta"
      end

      def feedback_items(organization_name, project_name, path, file_name, revision)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/feedback_items"
      end
    end
  end
end