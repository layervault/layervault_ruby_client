require 'faraday'
require 'layervault/mixins/authentication'
require 'layervault/mixins/configurable'
require 'layervault/mixins/connection'

require 'layervault/client/users'
require 'layervault/client/keypair'

module LayerVault
  class Client
    include LayerVault::Authentication
    include LayerVault::Configurable
    include LayerVault::Connection

    include LayerVault::Client::Users
    include LayerVault::Client::Keypair

    def initialize(options={})
      LayerVault::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || LayerVault.instance_variable_get(:"@#{key}"))
      end
    end

    def get(url, options = {})
      request :get, url, options
    end

  end
end