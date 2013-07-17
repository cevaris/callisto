class AddImagesAndReportToUserActivity < ActiveRecord::Migration
  def self.up
    add_column :user_activities, :report, :text
    add_column :user_activities, :video_url, :text
  end

  def self.down
    remove_column :user_activities, :report
    remove_column :user_activities, :video_url
  end
end
