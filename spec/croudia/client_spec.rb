require 'helper'

describe Croudia::Client do
  context 'with module counfiguration' do
    before do
      Croudia.configure do |config|
        Croudia::Configurable.keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Croudia.reset!
    end

    it 'inherits the module configuration' do
      client = Croudia::Client.new
      Croudia::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq key
      end
    end
  end

  context 'with class configuration' do
    before do
      @configuration = {
        connection_options: { timeout: 10 },
        client_id: 'CK',
        client_secret: 'CS',
        endpoint: 'http://twitter.com',
        middleware: Proc.new { },
        access_token: 'AT',
      }
    end

    context 'during initialization' do
      it 'overrides the modue configuration' do
        client = Croudia::Client.new(@configuration)
        Croudia::Configurable.keys.each do |key|
          expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
        end
      end
    end

    context 'after initialization' do
      it 'overrides the module configuration after initialization' do
        client = Croudia::Client.new
        client.configure do |config|
          @configuration.each do |key, value|
            config.send("#{key}=", value)
          end
        end
        Croudia::Configurable.keys.each do |key|
          expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
        end
      end
    end
  end

  describe '#delete' do
    before do
      stub_delete('/delete').with(query: { deleted: 'object' })
    end

    it 'allows custom delete requests' do
      Croudia::Client.new.delete('/delete', { deleted: 'object' })
      expect(a_delete('/delete').with(
        query: { deleted: 'object' }
      )).to have_been_made
    end
  end

  describe '#get' do
    before do
      stub_get('/get').with(query: { hoge: 'fuga' })
    end

    it 'allows custom get requests' do
      Croudia::Client.new.get('/get', { hoge: 'fuga' })
      expect(a_get('/get').with(
        query: { hoge: 'fuga'}
      )).to have_been_made
    end
  end

  describe '#post' do
    before do
      stub_post('/post').with(body: { posted: 'object' })
    end

    it 'allows custom post requests' do
      Croudia::Client.new.post('/post', { posted: 'object' })
      expect(a_post('/post').with(
        body: { posted: 'object' }
      )).to have_been_made
    end
  end

  describe '#put' do
    before do
      stub_put('/put').with(body: { updated: 'object'})
    end

    it 'allows custom delete requests' do
      Croudia::Client.new.put('/put', { updated: 'object' })
      expect(a_put('/put').with(
        body: { updated: 'object' }
      )).to have_been_made
    end
  end

  describe '#request' do
  end
end
