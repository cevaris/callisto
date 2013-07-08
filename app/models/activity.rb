class Activity < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user


  validates :name, presence: true, length: { minimum: 5 }

end
