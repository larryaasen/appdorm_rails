class Organization < ActiveRecord::Base
  attr_accessible :name, :user_id
  
  has_many :builds
  belongs_to :user    # foreign key user_id

  default_scope :order => 'organizations.created_at DESC'    # default ordering of builds when using user.builds

  validates :user_id, :presence => true
  validates :name,
            :presence => true,
            :allow_blank => false,
            :length => { :maximum => 255 }
end
