require 'spec_helper'

describe 'Organizations', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '/api/v1/organizations/:org_name' do
    it 'returns the Organization info' do
      @client.organization('LayerVault')
      assert_requested :get, layervault_url("organizations/LayerVault")
    end
  end
end