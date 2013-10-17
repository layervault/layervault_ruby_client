module LayerVault
  class File < LayerVault::Model
    class << self
      def for(organization, project, folder_path, file_name)
        resp = MultiJson.decode(LayerVault.client.file(organization, project, folder_path, file_name))
        instance = build_associations(resp, :revisions)
        instance.set_context(organization: organization, project: project, folder_path: folder_path, file_name: file_name)
      end
    end
  end
end