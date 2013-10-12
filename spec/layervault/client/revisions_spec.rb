require 'spec_helper'

describe 'Revisions', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.revision' do
    it 'returns the Revision info' do
      @client.revision('LayerVault', 'Designer News', 'Shirt', 'Blue.psd', 1)
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd/1")
    end
  end

  context '.previews' do
    it 'returns the Preview info' do
      @client.previews('LayerVault', 'Designer News', 'Shirt', 'Blue.psd', 1)
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd/1/previews")
    end
  end

  context '.revisions' do
    it 'returns the Revisions info' do
      @client.revisions('LayerVault', 'Designer News', 'Shirt', 'Blue.psd', 1, first_seen:1)
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd/1/revisions")
    end
  end

  context '.meta' do
    it 'returns the Meta info' do
      @client.meta('LayerVault', 'Designer News', 'Shirt', 'Blue.psd', 1)
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd/1/meta")
    end
  end
end