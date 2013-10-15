module LayerVault
  module Configurable
    attr_accessor :access_token, :api_endpoint, :client_id, :user_agent, :middleware
    attr_writer   :client_secret, :password

    class << self
      def keys
        @keys ||= [
          :access_token,
          :api_endpoint,
          :user_agent,
          :client_id,
          :client_secret,
          :password,
          :middleware
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

    alias setup reset!

    def api_endpoint
      File.join(@api_endpoint, "")
    end

    private

    def options
      Hash[LayerVault::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
  end
end
