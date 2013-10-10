module LayerVault
  module Connection
    def request(method, path, data, options={})
      @last_response = response = connection.send(method, URI.encode(path.to_s), data, options)
      response.body
    end

    def connection
      @connection ||= Faraday.new(url: @api_endpoint) do |conn|
        conn.request  :url_encoded
        conn.adapter  Faraday.default_adapter

        conn.headers[:user_agent]     = user_agent
        conn.headers[:Authorization]  = "Bearer #{access_token}"
      end
    end
  end
end