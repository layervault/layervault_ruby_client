require 'rubygems'
require 'rspec'
require 'json'
require 'layervault'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.configure_rspec_metadata!

  c.filter_sensitive_data("<LAYERVAULT_LOGIN>") do
      ENV['LAYERVAULT_LOGIN']
  end

  c.filter_sensitive_data("<LAYERVAULT_PASSWORD>") do
      ENV['LAYERVAULT_PASSWORD']
  end

  c.filter_sensitive_data("<<ACCESS_TOKEN>>") do
      ENV['LAYERVAULT_ACCESS_TOKEN']
  end

  c.filter_sensitive_data("<LAYERVAULT_CLIENT_ID>") do
      ENV['LAYERVAULT_CLIENT_ID']
  end

  c.filter_sensitive_data("<LAYERVAULT_CLIENT_SECRET>") do
      ENV['LAYERVAULT_CLIENT_SECRET']
  end

  c.default_cassette_options = {
    :serialize_with             => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true,
    :match_requests_on => [:method,
      VCR.request_matchers.uri_without_param(:md5)]
  }

  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].gsub(/\//, "_").split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_").downcase
    VCR.use_cassette(name) { example.call }
  end
end

def layervault_url(url)
  url =~ /^http/ ? url : "#{ENV['LAYERVAULT_API_ENDPOINT']}#{url}"
end

def random_md5
  identifier = ""
  chars = "0123456789abcdef"
  32.times { identifier << chars[rand(chars.size)] }
  identifier
end