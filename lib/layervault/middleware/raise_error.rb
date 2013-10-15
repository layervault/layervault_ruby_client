require 'faraday'
require 'layervault/response/error'

module LayerVault
  module Middleware
    class RaiseError < Faraday::Response::Middleware
      private
      def on_complete(response)
        if error = LayerVault::Response::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
