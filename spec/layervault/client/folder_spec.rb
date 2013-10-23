require 'spec_helper'

describe 'Folders', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
    @client.create_folder(test_org, test_project, 'Victim')
  end

  after do
    @client.delete_folder(test_org, test_project, 'Victim')
  end

  context '.folder' do
    it 'returns the Folder info' do
      @client.folder(test_org, test_project, 'Victim')
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/Victim")
    end
  end

  context '.create_folder' do
    it 'creates the Folder' do
      assert_requested :post, layervault_url("#{test_org}/#{test_project}/Victim")
    end
  end

  context '.delete_folder' do
    it 'deletes the folder' do
      @client.create_folder(test_org, test_project, 'VictimByeBye')
      @client.delete_folder(test_org, test_project, 'VictimByeBye')
      assert_requested :delete, layervault_url("#{test_org}/#{test_project}/VictimByeBye")
    end
  end

  context '.move_folder' do
    after do
      @client.delete_folder(test_org, test_project, 'Victim2')
    end

    it 'moves the folder' do
      @client.create_folder(test_org, test_project, 'VictimMove')
      @client.move_folder(test_org, test_project, 'VictimMove', to: 'Victim2')
      assert_requested :post, layervault_url("#{test_org}/#{test_project}/VictimMove/move")
    end
  end

  context '.change_folder_color' do
    it 'changes the folder color' do
      @client.change_folder_color(test_org, test_project, 'Victim', color: '#000000')
      assert_requested :put, layervault_url("#{test_org}/#{test_project}/Victim")
    end
  end
end