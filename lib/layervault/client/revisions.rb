module LayerVault
  class Client
    module Revisions
      def revision(organization_name, project_name, path, file_name, revision)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}"
      end

      def previews(organization_name, project_name, path, file_name, revision, options={})
        raise ClientParamsError.new("You must specify the :w (width) and :h (height) options for the previews.") unless options.fetch(:w, nil) && options.fetch(:h, nil)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/previews", options
      end

      def revisions(organization_name, project_name, path, file_name, revision, options={})
        raise ClientParamsError.new("You must specify the :first_seen or :latest_seen option for the file.") if options.fetch(:first_seen, nil) && options.fetch(:latest_seen, nil)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/revisions", options
      end

      def meta(organization_name, project_name, path, file_name, revision)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/#{revision}/meta"
      end
    end
  end
end