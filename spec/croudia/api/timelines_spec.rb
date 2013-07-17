require 'helper'

describe Croudia::API::Timelines do
  before do
    @client = Croudia::Client.new
  end

  describe '#public_timeline' do
    before do
      stub_get('/statuses/public_timeline.json').to_return(
        body: fixture(:timeline),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.public_timeline
      expect(a_get('/statuses/public_timeline.json')).to have_been_made
    end

    it 'returns array of Status object' do
      tl = @client.public_timeline
      expect(tl).to be_a Array
      tl.each { |status| expect(status).to be_a Croudia::Status }
    end
  end

  describe '#home_timeline' do
    before do
      stub_get('/statuses/home_timeline.json').to_return(
        body: fixture(:timeline),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.home_timeline
      expect(a_get('/statuses/home_timeline.json')).to have_been_made
    end

    it 'returns array of Status object' do
      tl = @client.home_timeline
      expect(tl).to be_a Array
      tl.each { |status| expect(status).to be_a Croudia::Status }
    end
  end

  describe '#user_timeline' do
    context 'without a screen_name' do
      it 'is not supported' do
        expect { @client.user_timeline }.to raise_error ArgumentError
      end
    end

    context 'with a screen_name (string)' do
      before do
        stub_get('/statuses/user_timeline.json').with(
          query: { screen_name: 'wktk' }
        ).to_return(
          body: fixture(:timeline),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource with the screen_name passed' do
        @client.user_timeline('wktk')
        expect(a_get('/statuses/user_timeline.json').with(
          query: { screen_name: 'wktk' }
        )).to have_been_made
      end
    end

    context 'with a user_id (integer)' do
      before do
        stub_get('/statuses/user_timeline.json').with(
          query: { user_id: 1234 }
        ).to_return(
          body: fixture(:timeline),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource with the user_id passed' do
        @client.user_timeline(1234)
        expect(a_get('/statuses/user_timeline.json').with(
          query: { user_id: 1234 }
        )).to have_been_made
      end
    end

    it 'returns array of Status object' do
      stub_get('/statuses/user_timeline.json').with(
        query: { screen_name: 'wktk' }
      ).to_return(
        body: fixture(:timeline),
        headers: { content_type: 'application/json; charset=utf-8' }
      )

      tl = @client.user_timeline('wktk')
      expect(tl).to be_a Array
      tl.each { |status| expect(status).to be_a Croudia::Status }
    end
  end

  describe '#mentions' do
    before do
      stub_get('/statuses/mentions.json').to_return(
        body: fixture(:timeline),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.mentions
      expect(a_get('/statuses/mentions.json')).to have_been_made
    end

    it 'returns array of Status object' do
      tl = @client.mentions
      expect(tl).to be_a Array
      tl.each { |status| expect(status).to be_a Croudia::Status }
    end
  end
end
