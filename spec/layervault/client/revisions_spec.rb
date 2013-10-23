require 'spec_helper'

describe 'Revisions', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
    @md5    = random_md5
    @client.create_file(test_org, test_project, '', 'Test.psd', md5: @md5, remote_url: 'http://jmd.fm/0j1f302H2t1X/download/Test.psd')
  end

  context '.revision' do
    it 'returns the Revision info' do
      @client.revision(test_org, test_project, '', 'Test.psd', 1)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/Test.psd/1")
    end
  end

  context '.previews' do
    it 'returns the Preview info' do
      @client.previews(test_org, test_project, '', 'Test.psd', 1, w:100, h:100)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/Test.psd/1/previews?h=100&w=100")
    end
  end

  context '.revisions' do
    it 'returns the Revisions info' do
      @client.revisions(test_org, test_project, '', 'Test.psd', 1, first_seen:1)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/Test.psd/1/revisions?first_seen=1")
    end
  end

  context '.meta' do
    it 'returns the Meta info' do
      @client.meta(test_org, test_project, '', 'Test.psd', 1)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}/Test.psd/1/meta")
    end
  end
end