require 'helper'

describe Croudia::Identity do
  describe '#initialize' do
    it 'sets arguments as instance variables' do
      Croudia::Identity.new(:hello => 'hi').instance_variable_get('@hello').should eq 'hi'
    end

    it 'converts a Unix time attribution named time to a Time object' do
      Croudia::Identity.new(:time => '1234567890').time.should be_a Time
    end

    it 'converts a date string named time to a Time object' do
      Croudia::Identity.new(:time => '2013-01-01 11:55').time.should be_a Time
    end

    it 'converts *_count into an Integer' do
      Croudia::Identity.new(:foo_count => '2012').foo_count.should eq 2012
    end
  end

  describe '#==' do
    it 'returns true when IDs match' do
      obj1 = Croudia::Identity.new(:id => '1', :username => 'wktk')
      obj2 = Croudia::Identity.new(:id => '1', :username => 'croudia')
      (obj1 == obj2).should be_true
    end

    it 'returns false when IDs do not match' do
      obj1 = Croudia::Identity.new(:id => '1', :username => 'wktk')
      obj2 = Croudia::Identity.new(:id => '2', :username => 'wktk')
      (obj1 == obj2).should be_false
    end

    it 'returns false when classes do not match' do
      obj1 = Croudia::Identity.new(:id => '1')
      obj2 = { :id => '1' }
      (obj1 == obj2).should be_false
    end
  end

  describe '#[]' do
    it 'returns the same name instance variable' do
      Croudia::Identity.new(:foo => 'bar')[:foo].should eq 'bar'
    end
  end

  describe '#id' do
    it 'returns @id, not object_id' do
      identity = Croudia::Identity.new(:id => '1')
      identity.id.should_not eq identity.object_id
      identity.id.should eq identity.instance_variable_get('@id')
    end
  end

  describe '#method_missing' do
    it 'returns the same name instance variable if set' do
      Croudia::Identity.new(:foo => 'bar').foo.should eq 'bar'
    end

    it 'returns nil if not set' do
      Croudia::Identity.new(:foo => 'bar').bar.should be_nil
    end
  end
end
