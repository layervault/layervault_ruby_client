require 'spec_helper'

describe 'Projects', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.project' do
    it 'returns the Organization info' do
      @client.project('LayerVault', 'api-playground')
      assert_requested :get, layervault_url("organizations/LayerVault/api-playground")
    end
  end

  context '.create_project' do
    after do
      @client.delete_project('LayerVault', 'Test Doge Project')
    end

    it 'Creates a new project' do
      project = @client.create_project('LayerVault', "Test Doge Project")
      expect(project).to_not be_empty
      assert_requested :post, layervault_url("organizations/LayerVault/Test Doge Project")
    end
  end

  context '.delete_project' do
    it 'Deletes the project' do
      @client.create_project('LayerVault', 'Test Doge Project Sacrifice')
      @client.delete_project('LayerVault', 'Test Doge Project Sacrifice')
      assert_requested :delete, layervault_url("organizations/LayerVault/Test Doge Project Sacrifice")
    end
  end
end