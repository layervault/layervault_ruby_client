require 'spec_helper'

describe 'Files', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
    @md5    = random_md5
    @client.create_file('LayerVault', 'api-playground', '', 'Test.psd', md5: @md5, remote_url: 'http://jmd.fm/0j1f302H2t1X/download/Test.psd')
  end

  after do
    @client.delete_file('LayerVault', 'api-playground', '', 'Test.psd', md5: @md5)
  end

  context '.create_file' do
    it 'creates the File' do
      assert_requested :put, layervault_url("LayerVault/api-playground/Test.psd")
    end
  end

  context '.file' do
    it 'returns the File info' do
      @client.file('LayerVault', 'api-playground', '', 'Test.psd')
      assert_requested :get, layervault_url("LayerVault/api-playground/Test.psd")
    end
  end

  context '.delete_file' do
    it 'deletes the File' do
      delete_md5 = random_md5
      @client.create_file('LayerVault', 'api-playground', '', 'DeleteTest.psd', md5: delete_md5, remote_url: 'http://jmd.fm/0j1f302H2t1X/download/Test.psd')
      @client.delete_file('LayerVault', 'api-playground', '', 'DeleteTest.psd', md5: delete_md5)
      assert_requested :delete, layervault_url("LayerVault/api-playground/DeleteTest.psd?md5=#{delete_md5}")
    end
  end

  context '.move_file' do
    it 'moves the File' do
      @client.move_file('LayerVault', 'api-playground', '', 'Test.psd', new_folder: 'Blog', new_file_name: 'MovedTest.psd')
      assert_requested :post, layervault_url("LayerVault/api-playground/Test.psd/move")
    end
  end

  context '.sync_check' do
    it 'performs a sync check on the path' do
      @client.sync_check('LayerVault', 'api-playground', '', 'Test.psd', md5: @md5+'a')
      assert_requested :get, layervault_url("LayerVault/api-playground/Test.psd/sync_check?md5=#{@md5}a")
    end
  end
end