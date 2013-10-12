require 'spec_helper'

describe 'Files', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.file' do
    it 'returns the File info' do
      @client.file('LayerVault', 'LayerVault', 'Blog', 'Sketches.psd')
      assert_requested :get, layervault_url("organizations/LayerVault/LayerVault/Blog/Sketches.psd")
    end
  end

  context '.delete_file' do
    before do
      @client.create_file('LayerVault', 'LayerVault', 'Blog', 'Test.psd')
    end

    it 'deletes the File info' do
      data = MultiJson.load(@client.file('LayerVault', 'LayerVault', 'Blog', 'Template.psd'))
      @client.delete_file('LayerVault', 'LayerVault', 'Blog', 'Template.psd', md5: data['md5'])
      assert_requested :get, layervault_url("organizations/LayerVault/LayerVault/Blog/Template.psd")
      assert_requested :delete, layervault_url("organizations/LayerVault/LayerVault/Blog/Template.psd?md5=#{data['md5']}")
    end
  end

  context '.create_file' do
    it 'creates the File' do
      @client.create_file('LayerVault', 'LayerVault', 'Blog', 'NewSketches.psd')
      assert_requested :post, layervault_url("organizations/LayerVault/LayerVault/Blog/NewSketches.psd")
    end
  end

  context '.move_file' do
    it 'moves the File' do
      @client.move_file('LayerVault', 'LayerVault', 'Blog', 'Sketches.psd', new_folder: 'Blog', new_file_name: 'MovedSketches.psd')
      assert_requested :post, layervault_url("organizations/LayerVault/LayerVault/Blog/Sketches.psd/move")
    end
  end

  context '.sync_check' do
    it 'performs a sync check on the path' do
      @client.sync_check('LayerVault', 'LayerVault', 'Blog', 'Sketches.psd', md5: 'asdaasdasddad')
      assert_requested :get, layervault_url("organizations/LayerVault/LayerVault/Blog/Sketches.psd/sync_check?md5=asdaasdasddad")
    end
  end
end