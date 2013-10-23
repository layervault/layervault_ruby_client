require 'spec_helper'

describe 'Organizations', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.organization' do
    it 'returns the Organization info' do
      @client.organization(test_org)
      assert_requested :get, layervault_url(test_org)
    end
  end
end