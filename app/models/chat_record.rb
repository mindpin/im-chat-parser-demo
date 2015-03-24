class ChatRecord

  include Mongoid::Document
  include Mongoid::Timestamps

  
  has_many :lines


end