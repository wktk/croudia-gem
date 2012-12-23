require 'helper'

describe Croudia::Scraper::Parser::Voices do
  describe '#voices' do
    context 'when parsing timeline' do
      before do
        stub_get('/voices/timeline').to_return(:body => fixture('voices_timeline'), :headers => {:content_type => 'text/html'})
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
        @timeline = @croudia.timeline
        @voice = @timeline[0]
      end

      it 'returns an array' do
        @timeline.should be_a Array
      end

      it 'returns an array of Croudia::Voice' do
        @timeline.each do |voice|
          voice.should be_a Croudia::Voice
        end
      end

      it 'gets id' do
        @voice.id.should eq '1001'
      end

      it 'gets user' do
        @voice.user.username.should eq 'username1'
      end

      it 'user is a Croudia::User' do
        @voice.user.should be_a Croudia::User
      end

      it 'gets text' do
        @voice.text.should eq 'text 1'
      end

      it 'gets favorited_count' do
        @voice.favorited_count.should eq 100
      end

      it 'converts favorited_count into an Integer' do
        @voice.favorited_count.should be_a Integer
      end

      it 'gets spreaded_count' do
        @voice.spreaded_count.should eq 950
      end

      it 'converts spreaded_count into an Integer' do
        @voice.spreaded_count.should be_a Integer
      end

      it 'gets time' do
        @voice.time.should eq Time.at(1356250231)
      end

      it 'converts time into a Time' do
        if (@voice.time)
          @voice.time.should be_a Time
        end
      end
    end

    context 'when parsing reply_list' do
      before do
        stub_get('/voices/reply_list').to_return(:body => fixture('voices_reply_list'), :headers => {:content_type => 'text/html'})
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
        @reply_list = @croudia.reply_list
        @voice = @reply_list[0]
      end

      it 'returns an array' do
        @reply_list.should be_a Array
      end

      it 'returns an array of Croudia::Voice' do
        @reply_list.each do |voice|
          voice.should be_a Croudia::Voice
        end
      end

      it 'gets id' do
        @voice.id.should eq '1001'
      end

      it 'gets user' do
        @voice.user.username.should eq 'wktk'
      end

      it 'user is a Croudia::User' do
        @voice.user.should be_a Croudia::User
      end

      it 'gets text' do
        @voice.text.should eq '@wktk wktk! wktk! wktk! (^-^)/'
      end

      it 'gets favorited_count' do
        @voice.favorited_count.should eq 500
      end

      it 'converts favorited_count into an Integer' do
        @voice.favorited_count.should be_a Integer
      end

      it 'gets spreaded_count' do
        @voice.spreaded_count.should eq 1000
      end

      it 'converts spreaded_count into an Integer' do
        @voice.spreaded_count.should be_a Integer
      end
    end
  end
end
