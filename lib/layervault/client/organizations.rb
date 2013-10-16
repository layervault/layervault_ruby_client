require 'multi_json'

module LayerVault
  class Client
    module Organizations
      def organization(name)
        resp = MultiJson.decode(get "organizations/#{name}")
        Organization.new(resp)
      end
    end
  end
end