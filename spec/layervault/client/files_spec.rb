require 'spec_helper'

describe 'Files', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.file' do
    it 'returns the File info' do
      @client.file('LayerVault', 'Designer News', 'Shirt', 'Blue.psd')
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd")
    end
  end

  context '.delete_file' do
    it 'deletes the File info' do
      @client.delete_file('LayerVault', 'Designer News', 'Shirt', 'Blue.psd')
      assert_requested :delete, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd")
    end
  end

  context '.create_file' do
    it 'creates the File' do
      @client.create_file('LayerVault', 'Designer News', 'Shirt', 'NewBlue.psd')
      assert_requested :post, layervault_url("organizations/LayerVault/Designer News/Shirt/NewBlue.psd")
    end
  end

  context '.move_file' do
    it 'moves the File' do
      @client.move_file('LayerVault', 'Designer News', 'Shirt', 'Blue.psd', 'Shirt', 'MovedBlue.psd')
      assert_requested :post, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd/move")
    end
  end

  context '.sync_check' do
    it 'performs a sync check on the path' do
      @client.sync_check('LayerVault', 'Designer News', 'Shirt', 'Blue.psd', md5: 'asdaasdasddad')
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News/Shirt/Blue.psd/sync_check?md5=asdaasdasddad")
    end
  end
end