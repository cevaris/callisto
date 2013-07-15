class CreateActivityImages < ActiveRecord::Migration
  def self.up
    create_table :activity_images do |t|
    	t.integer		:activity_id
    	
      t.timestamps
    end

    add_attachment :activity_images, :image
  end

  def self.down
    drop_table :activity_images
  end
end
