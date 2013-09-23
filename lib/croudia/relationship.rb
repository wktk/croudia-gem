require 'croudia/base'

class Croudia::Relationship < Croudia::Base
  attr_object_reader(
    [:relationship, :source] => Croudia::User,
    [:relationship, :target] => Croudia::User
  )

  def relationship
    self
  end
end
