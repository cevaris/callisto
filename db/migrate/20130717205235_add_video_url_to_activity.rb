class AddVideoUrlToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :video_url, :text
  end

  def self.down
    remove_column :activities, :video_url
  end
end
