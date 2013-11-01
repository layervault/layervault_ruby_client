require 'layervault/version'
require 'layervault/middleware/raise_error'

module LayerVault
  module Default

    API_ENDPOINT = "https://api.layervault.com/api/v1/".freeze
    USER_AGENT   = "LayerVault Ruby Gem #{LayerVault::VERSION}".freeze

    MIDDLEWARE = Faraday::Builder.new do |builder|
      builder.use LayerVault::Middleware::RaiseError
      builder.request :url_encoded
      builder.adapter Faraday.default_adapter
    end

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

      def user_agent
        ENV['LAYERVAULT_USER_AGENT'] || USER_AGENT
      end

      def middleware
        MIDDLEWARE
      end
    end
  end
end