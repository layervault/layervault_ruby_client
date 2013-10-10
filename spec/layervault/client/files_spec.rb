require 'spec_helper'

describe 'Files', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '/api/v1/organizations/:org_name/:project_name/:folder_path/:file_name' do
    it 'returns the Organization info' do
      @client.file('LayerVault', 'Designer News', 'Shirt', 'Blue.psd')
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd")
    end
  end
end