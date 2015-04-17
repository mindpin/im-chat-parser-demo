class JdUser

  include Mongoid::Document
  include Mongoid::Timestamps

  field :token,        type: String

end