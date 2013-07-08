class Activity < ActiveRecord::Base
	acts_as_taggable
  acts_as_taggable_on :tags

  belongs_to :user

  attr_accessible :description, :name

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 5 }

end
