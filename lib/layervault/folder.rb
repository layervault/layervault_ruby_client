require 'hashie'

module LayerVault
  class Folder < Hashie::Mash
    class << self
      def for(organization, project, folder_path)
        resp = MultiJson.decode(LayerVault.client.folder(organization, project, folder_path))
        new(resp)
      end
    end
  end
end