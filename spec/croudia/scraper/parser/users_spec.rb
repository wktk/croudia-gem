require 'helper'

describe Croudia::Scraper::Parser::Users do
  describe '#user_page' do
    context 'when it does not look like a user page' do
      it 'returns nil' do
        stub_get('/blank').to_return(:headers => {:content_type => 'text/html'})
        Croudia.user('blank').should be_nil
      end
    end

    context 'when it looks a user page' do
      before do
        stub_get('/wktk1').to_return(:body => fixture('user_wktk1'), :headers => {:content_type => 'text/html'})
        @user1 = Croudia.user('wktk1')
        stub_get('/wktk2').to_return(:body => fixture('user_wktk2'), :headers => {:content_type => 'text/html'})
        @user2 = Croudia.user('wktk2')
        stub_get('/wktk3').to_return(:body => fixture('user_wktk3'), :headers => {:content_type => 'text/html'})
        @user3 = Croudia.user('wktk3')
      end

      it 'gets username' do
        @user1.username.should eq 'wktk'
      end

      it 'gets nickname' do
        @user1.nickname.should eq 'wktk!'
      end

      it 'gets avatar url' do
        @user1.avatar.should eq 'https://croudia.com/testimages/download/9423'
      end

      it 'gets description' do
        @user1.description.should eq 'This is a dummy description for test.'
      end

      it 'trims description' do
        @user1.description.should_not match /^\s|\s$/
      end

      it 'gets voices_count' do
        @user1.voices_count.to_i.should eq 3381
      end

      it 'converts voices_count into an Integer' do
        @user1.voices_count.should be_a Integer
      end

      it 'gets following_count' do
        @user1.following_count.to_i.should eq 46
      end

      it 'converts following_count into an Integer' do
        @user1.following_count.should be_a Integer
      end

      it 'gets followers_count' do
        @user1.followers_count.to_i.should eq 468
      end

      it 'converts followers_count into an Integer' do
        @user1.followers_count.should be_a Integer
      end

      it 'gets album_count' do
        @user1.album_count.to_i.should eq 123
      end

      it 'converts album_count into an Integer' do
        @user1.album_count.should be_a Integer
      end

      it 'gets spreadia' do
        @user1.spreadia.to_i.should eq 2525
      end

      it 'converts spreadia into an Integer' do
        @user1.spreadia.should be_a Integer
      end

      it 'gets favodia' do
        @user1.favodia.to_i.should eq 4321
      end

      it 'converts favodia into an Integer' do
        @user1.favodia.should be_a Integer
      end

      context 'when url is set' do
        it 'gets url' do
          @user1.url.should eq 'http://wktk.in'
        end
      end

      context 'when url is not set' do
        it 'leaves url nil' do
          @user2.url.should be_nil
        end
      end

      context 'when location is set' do
        it 'gets location' do
          @user1.location.should eq 'Tokyo, Japan'
        end
      end

      context 'when location is not set' do
        it 'leaves location blank' do
          @user2.location.should be_nil
        end
      end

      context 'when following info included' do
        context 'when following' do
          it 'makes following true' do
            @user2.following.should be_true
          end
        end

        context 'when not following' do
          it 'makes following false' do
            @user3.following.should be_false
          end
        end
      end

      context 'when following info not included' do
        it 'leaves following nil' do
          @user1.following.should be_nil
        end
      end

      context 'when followed_by info included' do
        context 'when followed_by' do
          it 'makes followed_by true' do
            @user2.followed_by.should be_true
          end
        end

        context 'when not followed_by' do
          it 'makes followed_by false' do
            @user3.followed_by.should be_false
          end
        end
      end

      context 'when followed_by info not included' do
        it 'leaves followed_by nil' do
          @user1.followed_by.should be_nil
        end
      end
    end
  end

  describe '#user_list' do
    before do
      stub_get('/follows/following/wktk').to_return(:body => fixture('following_wktk'), :headers => {:content_type => 'text/html'})
      stub_get('/follows/follower/wktk').to_return(:body => fixture('follower_wktk'), :headers => {:content_type => 'text/html'})
      @following = Croudia.following('wktk')
      @followers = Croudia.followers('wktk')
    end

    context 'when following list provided' do
      it 'gets all users in the page' do
        @following.size.should eq 3
      end

      it 'gets username' do
        @following[0].username.should eq 'following1'
      end

      it 'gets nickname' do
        @following[0].nickname.should eq 'following 1'
      end

      it 'gets avatar url' do
        @following[0].avatar.should eq Croudia.endpoint + '/avatar1'
      end

      it 'gets description' do
        @following[0].description.should eq 'Description 1'
      end

      it 'trims description' do
        @following[0].description.should_not match /^\s|\s$/
      end

      context 'when following info provided' do
        context 'when following' do
          it 'sets following true' do
            @following[0].following.should be_true
          end
        end

        context 'when not following' do
          it 'sets following false' do
            @following[1].following.should be_false
          end
        end
      end

      context 'when following info not provided' do
        it 'leaves following nil' do
          @following[2].following.should be_false
        end
      end
    end

    context 'when follower list provided' do
      it 'gets all users in the page' do
        @followers.size.should eq 3
      end

      it 'gets username' do
        @followers[0].username.should eq 'follower1'
      end

      it 'gets nickname' do
        @followers[0].nickname.should eq 'follower 1'
      end

      it 'gets avatar url' do
        @followers[0].avatar.should eq Croudia.endpoint + '/avatar1'
      end

      it 'gets description' do
        @followers[0].description.should eq 'Description 1'
      end

      it 'trims description' do
        @followers[0].description.should_not match /^\s|\s$/
      end

      context 'when following info provided' do
        context 'when following' do
          it 'sets following true' do
            @followers[0].following.should be_true
          end
        end

        context 'when not following' do
          it 'sets following false' do
            @followers[1].following.should be_false
          end
        end
      end

      context 'when following info not provided' do
        it 'leaves following nil' do
          @followers[2].following.should be_false
        end
      end
    end
  end
end
