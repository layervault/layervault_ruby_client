require "layervault/version"
require "layervault/client"
require "layervault/mixins/configurable"
require "layervault/default_options"

module LayerVault
  
  class << self
    include LayerVault::Configurable

    def client 
      @client = LayerVault::Client.new(options) unless defined?(@client)
    end

  end

end
