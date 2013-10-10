require 'spec_helper'

describe 'Revisions', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '/api/v1/organizations/:org_name/:project_name/:folder_path/:file_name/:revision' do
    it 'returns the Organization info' do
      @client.revision('LayerVault', 'Designer News', 'Shirt', 'Blue.psd', 1)
      assert_requested :get, layervault_url("/organizations/LayerVault/Designer News/Shirt/Blue.psd/1")
    end
  end
end