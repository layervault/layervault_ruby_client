module LayerVault

  module Configurable

    attr_accessor :access_token, :api_endpoint, :client_id
    attr_writer   :client_secret, :password

    class << self
      def keys
        @keys ||= [
          :access_token,
          :api_endpoint,
          :client_id,
          :client_secret,
          :password
        ]
      end
    end

    def configure
      yield self
    end

    def reset!
      LayerVault::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", LayerVault::Default.options[key])
      end
      self
    end

    def api_endpoint
      File.join(@api_endpoint, "")
    end

    private

    def options
      Hash[LayerVault::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    def fetch_client_id_and_secret(overrides = {})
      opts = options.merge(overrides)
      opts.values_at :client_id, :client_secret
    end
  end
  
end
