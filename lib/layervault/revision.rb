module LayerVault
  class Revision < LayerVault::Model
    class << self
      def for(organization, project, folder_path, file_name, revision)
        resp = MultiJson.decode(LayerVault.client.revision(organization, project, folder_path, file_name, revision))
        instance = new(resp)
        instance.set_context(organization: organization, project: project, folder_path: folder_path, file_name: file_name, revision: revision)
      end
    end
  end
end