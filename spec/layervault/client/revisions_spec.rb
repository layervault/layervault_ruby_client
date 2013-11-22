require 'spec_helper'

describe 'Revisions', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
    @md5    = random_md5
    @client.create_file(test_org, test_project, '', 'dhh_face.png', md5: @md5, local_file_path: fixture_path_for('dhh.png'), content_type: 'image/png')
  end

  context '.revision' do
    it 'returns the Revision info' do
      @client.revision(test_org, test_project, '', 'dhh_face.png', 1)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/dhh_face.png/1")
    end
  end

  context '.preview' do
    it 'returns the specific Preview info' do
      @client.preview(test_org, test_project, '', 'dhh_face.png', 1, w: 100, h: 100)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/dhh_face.png/1/preview?h=100&w=100")
    end
  end

  context '.meta' do
    it 'returns the Meta info' do
      @client.meta(test_org, test_project, '', 'dhh_face.png', 1)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/dhh_face.png/1/meta")
    end
  end
end