module LayerVault
  class Client
    module Organizations
      def organization(name)
        get "#{name}"
      end
    end
  end
end