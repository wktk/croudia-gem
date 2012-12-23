require 'helper'

describe Croudia::User do
  describe '#to_s' do
    it 'returns username' do
      Croudia::User.new(:username => 'wktk').to_s.should eq 'wktk'
    end
  end

  describe '#initialize' do
    it 'sets @username as @id' do
      Croudia::User.new(:username => 'wktk').id.should eq 'wktk'
    end

    it 'converts spreadia into an Integer' do
      Croudia::User.new(:spreadia => '10').spreadia.should eq 10
    end

    it 'converts favodia into an Integer' do
      Croudia::User.new(:spreadia => '11').spreadia.should eq 11
    end
  end

  describe '#==' do
    it 'returns true if usernames are the same' do
      user1 = Croudia::User.new(:username => 'wktk', :name => 'wktk')
      user2 = Croudia::User.new(:username => 'wktk', :name => 'wktk!!')
      (user1 == user2).should be_true
    end

    it 'returns false if usernames are different' do
      user1 = Croudia::User.new(:username => 'wktk', :name => 'wktk')
      user2 = Croudia::User.new(:username => 'croudia', :name => 'wktk')
      (user1 == user2).should be_false
    end

    it 'returns false if classes are different' do
      user1 = Croudia::User.new(:username => 'wktk', :name => 'wktk')
      user2 = { :username => 'wktk', :name => 'wktk' }
      (user1 == user2).should be_false
    end
  end
end
