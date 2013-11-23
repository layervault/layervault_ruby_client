module LayerVault
  class Revision < LayerVault::Model
    class << self
      def for(organization, project, folder_path, file_name, revision)
        resp = MultiJson.decode(LayerVault.client.revision(organization, project, folder_path, file_name, revision))
        instance = new(resp)
        instance.set_context(organization: organization, project: project, folder_path: folder_path, file_name: file_name, revision: revision)
      end
    end

    def preview(width, height)
      LayerVault.client.preview(context.organization, context.project, context.folder_path, context.file_name, context.revision, w: width, h: height)
    end

    def meta
      LayerVault.client.meta(context.organization, context.project, context.folder_path, context.file_name, context.revision)
    end
  end
end