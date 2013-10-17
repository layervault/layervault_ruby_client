module LayerVault
  class Folder < LayerVault::Model
    class << self
      def for(organization, project, folder_path)
        resp = MultiJson.decode(LayerVault.client.folder(organization, project, folder_path))
        instance = build_associations(resp, :folders, :files)
        instance.set_context(organization: organization, project: project, folder_path: folder_path)
      end
    end
  end
end