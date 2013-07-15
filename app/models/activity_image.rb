class ActivityImage < ActiveRecord::Base
	belongs_to :activity

  has_attached_file :image, 
  	styles: { 
			thumb: '100x100>', 
			square: '200x200#', 
			medium: '300x300>',
			large: '500x500>' 
		}
end
