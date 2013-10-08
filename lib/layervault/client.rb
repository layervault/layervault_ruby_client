require 'layervault/mixins/authentication'
require 'layervault/mixins/configurable'

module LayerVault
  class Client
    include LayerVault::Authentication
    include LayerVault::Configurable

    def initialize(options)
      LayerVault::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || LayerVault.instance_variable_get(:"@#{key}"))
      end
    end
  end
end