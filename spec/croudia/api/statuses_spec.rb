require 'helper'

describe Croudia::API::Statuses do
  before do
    @client = Croudia::Client.new
  end

  describe '#update' do
    before do
      stub_post('/statuses/update.json').with(
        body: {
          status: 'Hello',
          in_reply_to_status_id: '1234',
        }
      ).to_return(
        body: fixture(:status),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    context 'when text is passed as a string' do
      it 'requests the correct resource' do
        @client.update('Hello', in_reply_to_status_id: 1234)
        expect(a_post('/statuses/update.json').with(
          body: { 
            status: 'Hello',
            in_reply_to_status_id: '1234',
          }
        )).to have_been_made
      end
    end

    context 'when text is passed as a value of hash' do
      it 'requests the correct resource' do
        @client.update(status: 'Hello', in_reply_to_status_id: 1234)
        expect(a_post('/statuses/update.json').with(
          body: {
            status: 'Hello',
            in_reply_to_status_id: '1234',
          }
        )).to have_been_made
      end
    end

    it 'returns a Status object' do
      expect(
        @client.update('Hello', in_reply_to_status_id: 1234)
      ).to be_a Croudia::Status
    end
  end

  describe '#update_with_media' do
    before do
      stub_post('/statuses/update_with_media.json').to_return(
        body: fixture(:status),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    context 'when passing each argument' do
      it 'requests the correct resource' do
        @client.update_with_media('Hi', fixture('image.jpg'))
        expect(a_post('/statuses/update_with_media.json')).to have_been_made
      end
    end

    context 'when passing a Hash' do
      it 'requests the correct resource' do
        @client.update_with_media(status: 'Hi', media: fixture('image.jpg'))
        expect(a_post('/statuses/update_with_media.json')).to have_been_made
      end
    end

    it 'returns a Croudia::Status' do
      subject = @client.update_with_media('Hi', fixture('image.jpg'))
      expect(subject).to be_a Croudia::Status
    end
  end

  describe '#destroy_status' do
    before do
      stub_post('/statuses/destroy/1234.json').to_return(
        body: fixture(:status),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.destroy_status(1234)
      expect(a_post('/statuses/destroy/1234.json')).to have_been_made
    end

    it 'returns a Status object' do
      expect(@client.destroy_status(1234)).to be_a Croudia::Status
    end
  end

  describe '#status' do
    before do
      stub_get('/statuses/show/1234.json').to_return(
        body: fixture(:status),
        header: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.status(1234)
      expect(a_get('/statuses/show/1234.json')).to have_been_made
    end

    it 'returns a Status object' do
      expect(@client.status(1234)).to be_a Croudia::Status
    end
  end

  describe '#spread' do
    before do
      stub_post('/statuses/spread/1234.json').to_return(
        body: fixture(:status),
        header: { content_type: 'application/json: charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.spread(1234)
      expect(a_post('/statuses/spread/1234.json')).to have_been_made
    end

    it 'returns a Status object' do
      expect(@client.spread(1234)).to be_a Croudia::Status
    end
  end

  describe '#share' do
    before do
      stub_post('/statuses/share.json').with(
        body: { id: '1234', status: 'Hello' }
      ).to_return(
        body: fixture(:status),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    context 'when text is passed as a string' do
      it 'requests the correct resource' do
        @client.share('1234', 'Hello')
        expect(a_post('/statuses/share.json').with(
          body: { id: '1234', status: 'Hello' }
        )).to have_been_made
      end
    end

    context 'when text is passed as a value of hash' do
      it 'requests the correct resource' do
        @client.share(status: 'Hello', id: 1234)
        expect(a_post('/statuses/share.json').with(
          body: { id: '1234', status: 'Hello' }
        )).to have_been_made
      end
    end

    it 'returns a Status object' do
      expect(@client.share(1234, 'Hello')).to be_a Croudia::Status
    end
  end

  describe '#share_with_media' do
    before do
      stub_post('/statuses/share_with_media.json').to_return(
        body: fixture(:status),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    context 'when passing each argument' do
      it 'requests the correct resource' do
        @client.share_with_media(1234, 'Hi', fixture('image.jpg'))
        expect(a_post('/statuses/share_with_media.json')).to have_been_made
      end
    end

    context 'when passing a Hash' do
      it 'requests the correct resource' do
        @client.share_with_media(id: 1234, status: 'Hi', media: fixture('image.jpg'))
        expect(a_post('/statuses/share_with_media.json')).to have_been_made
      end
    end

    it 'returns a Croudia::Status' do
      subject = @client.share_with_media(1234, 'Hi', fixture('image.jpg'))
      expect(subject).to be_a Croudia::Status
    end
  end
end
