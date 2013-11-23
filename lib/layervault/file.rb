module LayerVault
  class File < LayerVault::Model
    class << self
      def for(organization, project, folder_path, file_name)
        resp = MultiJson.decode(LayerVault.client.file(organization, project, folder_path, file_name))
        instance = build_associations(resp, :revisions)
        instance.set_context(organization: organization, project: project, folder_path: folder_path, file_name: file_name )
      end
    end

    def previews(width, height)
      LayerVault.client.previews(context.organization, context.project, context.folder_path, context.file_name, w: width, h: height)
    end

    def revisions(options={})
      LayerVault.client.revisions(context.organization, context.project, context.folder_path, context.file_name, first_seen: options[:first_seen], last_seen: options[:last_seen])
    end
  end
end