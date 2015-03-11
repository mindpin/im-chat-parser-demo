class User

  include Mongoid::Document
  include Mongoid::Timestamps

  field :qq_num,             type: String
  field :name_list,             type: String

  
  has_many :lines

  validates :name_list, :presence => true

  validates_uniqueness_of :name_list, :case_sensitive => false

  # default_scope -> { order('id desc') }


  def names
    name_list.split(',')
  end


end