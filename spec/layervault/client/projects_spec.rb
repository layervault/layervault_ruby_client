require 'spec_helper'

describe 'Projects', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '/api/v1/organizations/:org_name/:project_name' do
    it 'returns the Organization info' do
      @client.project('LayerVault', 'Designer News')
      assert_requested :get, layervault_url("/organizations/LayerVault/Designer News")
    end
  end
end