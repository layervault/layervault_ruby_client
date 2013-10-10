module LayerVault
  class Client
    module Organizations
      def organization(name)
        get "organizations/#{name}"
      end
    end
  end
end