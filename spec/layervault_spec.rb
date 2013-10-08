require 'spec_helper'

describe "The LayerVault API client" do
  
  context "Creating the client" do
    it "instantiates a client with proper configuration" do
      expect(LayerVault.client).to be_kind_of LayerVault::Client
    end
  end

end