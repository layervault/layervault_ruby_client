require 'spec_helper'

describe 'Keypairs', :vcr do

  before do
    LayerVault.reset!
    @client = LayerVault::Client.new
  end

  context '.keypair' do
    it 'returns the Keypair info' do
      @keys = @client.keypair
      assert_requested :get, layervault_url("keypair")
    end
  end
end