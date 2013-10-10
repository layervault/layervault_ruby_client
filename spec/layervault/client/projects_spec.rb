require 'spec_helper'

describe 'Projects', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context 'GET /api/v1/organizations/:org_name/:project_name' do
    it 'returns the Organization info' do
      @client.project('LayerVault', 'Designer News')
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News")
    end
  end

  context 'POST /api/v1/organizations/:org_name/:project_name' do
    it 'Creates a new project' do
      project = @client.create_project('LayerVault', 'Test Doge Project')
      expect(project).to_not be_empty
      assert_requested :post, layervault_url("organizations/LayerVault/Test Doge Project")
    end
  end
end