require 'spec_helper'

describe 'Projects', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.folder' do
    it 'returns the Folder info' do
      @client.folder('LayerVault', 'Designer News', 'Shirt')
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News/Shirt")
    end
  end

  context '.create_folder' do
    it 'creates the Folder' do
      @client.create_folder('LayerVault', 'Designer News', 'NewShirt')
      assert_requested :post, layervault_url("organizations/LayerVault/Designer News/NewShirt")
    end
  end

  context '.move_folder' do
    it 'moves the folder' do
      @client.move_folder('LayerVault', 'Designer News', 'Shirt', to: 'FancyShirt')
      assert_requested :post, layervault_url("organizations/LayerVault/Designer News/Shirt/move")
    end
  end

  context '.change_folder_color' do
    it 'changes the folder color' do
      @client.change_folder_color('LayerVault', 'Designer News', 'Shirt', color: '#000000')
      assert_requested :put, layervault_url("organizations/LayerVault/Designer News/Shirt")
    end
  end

  context '.delete_folder' do
    it 'deletes the folder' do
      @client.delete_folder('LayerVault', 'Designer News', 'Shirt')
      assert_requested :delete, layervault_url("organizations/LayerVault/Designer News/Shirt")
    end
  end
end