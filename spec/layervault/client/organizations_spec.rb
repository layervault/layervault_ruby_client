require 'spec_helper'

describe 'Organizations', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.organization' do
    it 'returns the Organization info' do
      @client.organization('LayerVault')
      assert_requested :get, layervault_url("LayerVault")
    end
  end
end