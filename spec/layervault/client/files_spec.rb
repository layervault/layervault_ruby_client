require 'spec_helper'
require 'digest/md5'

describe 'Files', :vcr do

  before :each do
    LayerVault.reset!
    @client = LayerVault::Client.new
    @md5 = Digest::MD5.hexdigest(::File.read(fixture_path_for('dhh.png')))
    @client.create_file(test_org, test_project, '', 'dhh_face.png', md5: @md5, local_file_path: fixture_path_for('dhh.png'), content_type: 'image/png')
  end

  describe 'Basic operations' do
    after do
      @client.delete_file(test_org, test_project, '', 'dhh_face.png', md5: @md5)
    end

    describe '.create_file' do
      it 'creates the File' do
        assert_requested :put, layervault_url("layervault-test/test-api-playground/dhh_face.png")
      end
    end

    describe '.file' do
      it 'returns the File info' do
        @client.file(test_org, test_project, '', 'dhh_face.png')
        assert_requested :get, layervault_url("layervault-test/test-api-playground/dhh_face.png")
      end
    end

    describe '.delete_file' do
      it 'deletes the File' do
        @client.create_file(test_org, test_project, '', 'Delete_dhh_face.png', md5: @md5, local_file_path: fixture_path_for('dhh.png'), content_type: 'image/png')
        @client.delete_file(test_org, test_project, '', 'Delete_dhh_face.png', md5: @md5)
        assert_requested :delete, layervault_url("layervault-test/test-api-playground/Delete_dhh_face.png?md5=#{@md5}")
      end
    end
  end

  describe '.move_file' do
    after do
      @client.delete_project(test_org, 'UltimateFakeTestDestinationProject')
    end

    it 'moves the File' do
      @client.move_file(test_org, test_project, '', 'dhh_face.png', new_folder: 'UltimateFakeTestDestinationProject', new_file_name: 'MovedDhh.png')
      assert_requested :post, layervault_url("layervault-test/test-api-playground/dhh_face.png/move")
    end
  end

  describe '.sync_check' do
    it 'performs a sync check on the path' do
      @client.sync_check(test_org, test_project, '', 'dhh_face.png', md5: @md5+'a')
      assert_requested :get, layervault_url("layervault-test/test-api-playground/dhh_face.png/sync_check?md5=#{@md5}a")
    end
  end

  describe '.revisions' do
    it 'returns the Revisions info' do
      @client.revisions(test_org, test_project, '', 'dhh_face.png', first_seen:1)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/dhh_face.png/revisions?first_seen=1")
    end
  end

  describe '.previews' do
    it 'returns the Preview info' do
      @client.previews(test_org, test_project, '', 'dhh_face.png', w: 100, h: 100)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/dhh_face.png/previews?h=100&w=100")
    end
  end
end