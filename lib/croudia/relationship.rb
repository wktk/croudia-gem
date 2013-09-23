require 'croudia/base'

class Croudia::Relationship < Croudia::Base
  def relationship
    self
  end

  def source
    @source ||= Croudia::User.new(@attrs['relationship']['source'])
  end

  def target
    @target ||= Croudia::User.new(@attrs['relationship']['target'])
  end
end
