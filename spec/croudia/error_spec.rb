require 'helper'

describe Croudia::Error do
  it 'is a kind of Error' do
    Croudia::Error.kind_of? StandardError
  end
end

describe Croudia::NotLoggedInError do
  it 'is a kind of Croudia::Error' do
    Croudia::NotLoggedInError.kind_of? Croudia::Error
  end
end
