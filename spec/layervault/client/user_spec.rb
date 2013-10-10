require 'spec_helper'

describe 'Users', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '/api/v1/me' do
    it 'returns the User info as JSON' do
      @client.me
      assert_requested :get, layervault_url("me")
    end
  end
end