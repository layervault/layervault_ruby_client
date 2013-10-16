require 'hashie'

module LayerVault
  class Project < Hashie::Mash
    class << self
      def for(organization, project)
        resp = MultiJson.decode(LayerVault.client.project(organization, project))
        new(resp)
      end
    end
  end
end