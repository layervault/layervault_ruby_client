require 'multi_json'

module LayerVault
  class Client
    module Users
      def me
        resp = MultiJson.decode(get "me")
        User.new(resp)
      end
    end
  end
end