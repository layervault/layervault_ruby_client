require 'hashie'

module LayerVault
  class Revision < Hashie::Mash
    class << self
      def for(organization, project, folder_path, file_name, revision)
        resp = MultiJson.decode(LayerVault.client.revision(organization, project, folder_path, file_name, revision))
        new(resp)
      end
    end
  end
end