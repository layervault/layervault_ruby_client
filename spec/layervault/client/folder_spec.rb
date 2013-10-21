require 'spec_helper'

describe 'Folders', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
    @client.create_folder('LayerVault', 'api-playground', 'Victim')
  end

  after do
    @client.delete_folder('LayerVault', 'api-playground', 'Victim')
  end

  context '.folder' do
    it 'returns the Folder info' do
      @client.folder('LayerVault', 'api-playground', 'Victim')
      assert_requested :get, layervault_url("LayerVault/api-playground/Victim")
    end
  end

  context '.create_folder' do
    it 'creates the Folder' do
      assert_requested :post, layervault_url("LayerVault/api-playground/Victim")
    end
  end

  context '.delete_folder' do
    it 'deletes the folder' do
      @client.create_folder('LayerVault', 'api-playground', 'VictimByeBye')
      @client.delete_folder('LayerVault', 'api-playground', 'VictimByeBye')
      assert_requested :delete, layervault_url("LayerVault/api-playground/VictimByeBye")
    end
  end

  context '.move_folder' do
    after do
      @client.delete_folder('LayerVault', 'api-playground', 'Victim2')
    end

    it 'moves the folder' do
      @client.create_folder('LayerVault', 'api-playground', 'VictimMove')
      @client.move_folder('LayerVault', 'api-playground', 'VictimMove', to: 'Victim2')
      assert_requested :post, layervault_url("LayerVault/api-playground/VictimMove/move")
    end
  end

  context '.change_folder_color' do
    it 'changes the folder color' do
      @client.change_folder_color('LayerVault', 'api-playground', 'Victim', color: '#000000')
      assert_requested :put, layervault_url("LayerVault/api-playground/Victim")
    end
  end
end