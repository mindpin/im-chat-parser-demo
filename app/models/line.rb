class Line

  include Mongoid::Document
  include Mongoid::Timestamps

  field :text,             type: String
  field :time,        type: String

  
  belongs_to :user
  belongs_to :chat_record

  validates :text, :user, :presence => true

  # validates_uniqueness_of :text, :case_sensitive => false


  # default_scope -> { order('id desc') }


end