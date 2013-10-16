require 'hashie'

module LayerVault
  class File < Hashie::Mash
    class << self
      def for(organization, project, folder_path, file_name)
        resp = MultiJson.decode(LayerVault.client.file(organization, project, folder_path, file_name))
        new(resp)
      end
    end
  end
end