class Charge
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :token

end
