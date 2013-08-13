class Activity < ActiveRecord::Base
	MAX_NUM_TAGS = 3

	acts_as_taggable

  acts_as_taggable_on :tags

  attr_accessible :description, :name, :tag_list, :video_url, :activity_images_attributes

  belongs_to :user
  has_many :activity_images

  accepts_nested_attributes_for :activity_images, :allow_destroy => true    

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :tag_list, presence: true, length: { minimum: 1 }
  validate :maximum_amount_of_tags
	
	def maximum_amount_of_tags
		number_of_tags = tag_list_cache_on('tags').uniq.length
		errors.add(:base, "Invalid number of tags, max is #{Activity::MAX_NUM_TAGS}") if number_of_tags > Activity::MAX_NUM_TAGS
	end
	
end
