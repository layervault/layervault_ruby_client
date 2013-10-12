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
      rev = SecureRandom.random_number(100)
      project = @client.create_project('LayerVault', "Test Doge Project #{rev}")
      expect(project).to_not be_empty
      assert_requested :post, layervault_url("organizations/LayerVault/Test Doge Project #{rev}")
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