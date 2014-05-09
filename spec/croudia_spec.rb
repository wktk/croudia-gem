require 'helper'

describe Croudia do
  context 'when delegating to Croudia::Client' do
    before do
      stub_get('/statuses/public_timeline.json').to_return(
        body: fixture('timeline'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      Croudia.public_timeline
      expect(a_get('/statuses/public_timeline.json')).to have_been_made
    end

    it 'returns the same result to Croudia::Client' do
      expect(Croudia.public_timeline).to eq Croudia::Client.new.public_timeline
    end
  end

  describe '.client' do
    it 'returns a Croudia::Client' do
      expect(Croudia.client).to be_a Croudia::Client
    end
  end

  describe '.respond_to?' do
    it 'delegates to Croudia::Client' do
      expect(Croudia.respond_to?(:public_timeline)).to be_true
    end
  end

  describe '.configure' do
    after do
      Croudia.reset!
    end

    Croudia::Configurable.keys.each do |key|
      it "sets the #{key}" do
        Croudia.configure do |config|
          config.send("#{key}=", key)
        end
        expect(Croudia.instance_variable_get(:"@#{key}")).to eq key
      end
    end
  end
end
