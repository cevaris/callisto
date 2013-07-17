class CreateUserActivityImages < ActiveRecord::Migration
	def self.up
    create_table :user_activity_images do |t|
    	t.integer		:user_activity_id
    	
      t.timestamps
    end

    add_attachment :user_activity_images, :image
  end

  def self.down
    drop_table :user_activity_images
  end

end
