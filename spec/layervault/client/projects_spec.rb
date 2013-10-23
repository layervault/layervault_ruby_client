require 'spec_helper'

describe 'Projects', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.project' do
    it 'returns the Organization info' do
      @client.project(test_org, test_project)
      assert_requested :get, layervault_url("#{test_org}/#{test_project}")
    end
  end

  context '.create_project' do
    after do
      @client.delete_project(test_org, 'Test Doge Project')
    end

    it 'Creates a new project' do
      project = @client.create_project(test_org, "Test Doge Project")
      expect(project).to_not be_empty
      assert_requested :post, layervault_url("#{test_org}/Test Doge Project")
    end
  end

  context '.delete_project' do
    it 'Deletes the project' do
      @client.create_project(test_org, 'Test Doge Project Sacrifice')
      @client.delete_project(test_org, 'Test Doge Project Sacrifice')
      assert_requested :delete, layervault_url("#{test_org}/Test Doge Project Sacrifice")
    end
  end

  context '.move_project' do
    it 'Moves the project' do
      @client.create_project(test_org, 'TestMoveProject')
      @client.move_project(test_org, 'TestMoveProject', to: 'DestinationTestFolder')
      assert_requested :post, layervault_url("#{test_org}/TestMoveProject/move")
    end
  end

  context '.change_project_folder_color' do
    it 'changes the folder color' do
      @client.change_project_folder_color(test_org, test_project, color: '#000000')
      assert_requested :put, layervault_url("#{test_org}/#{test_project}")
    end
  end
end