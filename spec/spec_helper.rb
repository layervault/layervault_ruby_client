require 'rubygems'
require 'rspec'
require 'json'
require 'layervault'

require 'vcr'
VCR.configure do |c|
  c.configure_rspec_metadata!

  c.default_cassette_options = {
    :serialize_with             => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true
  }
  
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end


RSpec.configure do |config|

end