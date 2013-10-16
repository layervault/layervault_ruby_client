module LayerVault
  class Folder < LayerVault::Model
    class << self
      def for(organization, project, folder_path)
        resp = MultiJson.decode(LayerVault.client.folder(organization, project, folder_path))
        new(resp)
      end
    end
  end
end