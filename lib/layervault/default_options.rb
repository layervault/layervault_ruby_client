require 'layervault/version'

module LayerVault
  module Default

    API_ENDPOINT = "https://layervault.com/api/v1/".freeze
    USER_AGENT   = "LayerVault Ruby Gem #{LayerVault::VERSION}".freeze

    class << self
      def options
        Hash[LayerVault::Configurable.keys.map{|key| [key, send(key)]}]
      end

      def access_token
        ENV['LAYERVAULT_ACCESS_TOKEN']
      end

      def api_endpoint
        ENV['LAYERVAULT_API_ENDPOINT'] || API_ENDPOINT
      end

      def client_id
        ENV['LAYERVAULT_CLIENT_ID']
      end

      def client_secret
        ENV['LAYERVAULT_SECRET']
      end

      def password
        ENV['LAYERVAULT_PASSWORD']
      end

      def user_agent
        ENV['LAYERVAULT_USER_AGENT'] || USER_AGENT
      end
    end
  end
end