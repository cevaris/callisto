class AddPrivacyToUserActivity < ActiveRecord::Migration
  def self.up
    add_column :user_activities, :privacy, :string, default: UserActivity::FRIENDS
  end

  def self.down
    remove_column :user_activities, :privacy
  end
end