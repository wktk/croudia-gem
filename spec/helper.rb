require 'croudia'
require 'rspec'
require 'webmock/rspec'

def a_get(path)
  a_request(:get, Croudia::Default::ENDPOINT + path)
end

def a_post(path)
  a_request(:post, Croudia::Default::ENDPOINT + path)
end

def a_put(path)
  a_request(:put, Croudia::Default::ENDPOINT + path)
end

def a_delete(path)
  a_request(:delete, Croudia::Default::ENDPOINT + path)
end

def stub_any(path)
  stub_request(:any, Croudia::Default::ENDPOINT + path)
end

def stub_get(path)
  stub_request(:get, Croudia::Default::ENDPOINT + path)
end

def stub_post(path)
  stub_request(:post, Croudia::Default::ENDPOINT + path)
end

def stub_put(path)
  stub_request(:put, Croudia::Default::ENDPOINT + path)
end

def stub_delete(path)
  stub_request(:delete, Croudia::Default::ENDPOINT + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  file = file.to_s
  file += '.json' unless file.include? '.'
  File.new(fixture_path + '/' + file)
end
