require 'spec_helper'

describe 'Projects', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.project' do
    it 'returns the Organization info' do
      @client.project('LayerVault', 'Designer News')
      assert_requested :get, layervault_url("organizations/LayerVault/Designer News")
    end
  end

  context '.create_project' do
    it 'Creates a new project' do
      project = @client.create_project('LayerVault', 'Test Doge Project')
      expect(project).to_not be_empty
      assert_requested :post, layervault_url("organizations/LayerVault/Test Doge Project")
    end
  end

  context '.delete_project' do
    it 'Creates a new project' do
      @client.create_project('LayerVault', 'Test Doge Project')
      @client.delete_project('LayerVault', 'Test Doge Project')
      assert_requested :delete, layervault_url("organizations/LayerVault/Test Doge Project")
    end
  end
end