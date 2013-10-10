require 'spec_helper'

describe 'Projects', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '/api/v1/organizations/:org_name/:project_name/:folder_path' do
    it 'returns the Organization info' do
      @client.folder('LayerVault', 'Designer News', 'Shirt')
      assert_requested :get, layervault_url("/organizations/LayerVault/Designer News/Shirt")
    end
  end
end