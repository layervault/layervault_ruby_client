require 'faraday'

require 'layervault/mixins/authentication'
require 'layervault/mixins/configurable'
require 'layervault/mixins/connection'

require 'layervault/client/users'
require 'layervault/client/keypair'
require 'layervault/client/organizations'
require 'layervault/client/projects'
require 'layervault/client/folders'
require 'layervault/client/files'
require 'layervault/client/revisions'

module LayerVault

  class ClientParamsError < Exception ; end

  class Client
    include LayerVault::Authentication
    include LayerVault::Configurable
    include LayerVault::Connection

    include LayerVault::Client::Users
    include LayerVault::Client::Keypair
    include LayerVault::Client::Organizations
    include LayerVault::Client::Projects
    include LayerVault::Client::Folders
    include LayerVault::Client::Files
    include LayerVault::Client::Revisions

    def initialize(options={})
      LayerVault::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || LayerVault.instance_variable_get(:"@#{key}"))
      end
    end

    def get(url, options = {})
      request :get, url, options
    end

    def post(url, options = {})
      request :post, url, options
    end

    def put(url, options = {})
      request :put, url, options
    end

    def delete(url, options = {})
      request :delete, url, options
    end

  end
end