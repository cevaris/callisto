class Activity < ActiveRecord::Base
	acts_as_taggable
  acts_as_taggable_on :tags

  attr_accessible :description, :name, :tag_list, :activity_images_attributes

  belongs_to :user
  has_many :activity_images
 

  accepts_nested_attributes_for :activity_images, :allow_destroy => true    

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 5 }

end
