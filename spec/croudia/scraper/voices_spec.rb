require 'helper'

describe Croudia::Scraper::Voices do
  describe '#timeline' do
    context 'when logged in' do
      before do
        stub_get('/voices/timeline').to_return(:body => fixture('voices_timeline'), :headers => {:content_type => 'text/html'})
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
      end

      it 'does not raise an error' do
        expect{ @croudia.timeline }.not_to raise_error
      end

      it 'gets the correct resource' do
        @croudia.timeline
        a_get('/voices/timeline').should have_been_made
      end

      it 'returns an array' do
        @croudia.timeline.should be_a Array
      end

      it 'returns an array of Croudia::Voice' do
        @croudia.timeline.each do |voice|
          voice.should be_a Croudia::Voice
        end
      end
    end

    context 'when not logged in' do
      it 'raises an error' do
        expect{ Croudia::Scraper.new.timeline }.to raise_error
      end
    end
  end

  describe '#reply_list' do
    context 'when logged in' do
      before do
        stub_get('/voices/reply_list').to_return(:body => fixture('voices_reply_list'), :headers => {:content_type => 'text/html'})
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
      end

      it 'does not raise an error' do
        expect{ @croudia.reply_list }.not_to raise_error
      end

      it 'gets the correct resource' do
        @croudia.reply_list
        a_get('/voices/reply_list').should have_been_made
      end

      it 'returns an array of Croudia::Voice' do
        @croudia.reply_list.each do |voice|
          voice.should be_a Croudia::Voice
        end
      end
    end

    context 'when not logged in' do
      it 'raises an error' do
        expect{ Croudia::Scraper.new.reply_list }.to raise_error
      end
    end
  end

  describe '#update' do
    context 'when not logged in' do
      it 'raises an error' do
        expect{ Croudia::Scraper.new.update('Hi') }.to raise_error
      end
    end

    context 'when logged in' do
      before do
        stub_get('/voices/written').to_return(:body => fixture('voices_written'), :headers => {:content_type => 'text/html'})
        stub_post('/voices/write').to_return(:headers => {:content_type => 'text/html'})
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
      end

      it 'posts to the correct resource' do
        @croudia.update('Hello')
        a_get('/voices/written').should have_been_made
        a_post('/voices/write').should have_been_made
      end
    end
  end
end
