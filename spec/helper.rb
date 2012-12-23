require 'croudia'
require 'rspec'
require 'webmock/rspec'

def a_get(path)
  a_request(:get, Croudia.endpoint + path)
end

def a_post(path)
  a_request(:post, Croudia.endpoint + path)
end

def stub_any(path)
  stub_request(:any, Croudia.endpoint + path)
end

def stub_get(path)
  stub_request(:get, Croudia.endpoint + path)
end

def stub_post(path)
  stub_request(:post, Croudia.endpoint + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  file += '.html' unless file.include? '.'
  File.new(fixture_path + '/' + file)
end
