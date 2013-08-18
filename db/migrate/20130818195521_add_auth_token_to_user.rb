class AddAuthTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :authtoken, :text
    
    User.all.each do |user|
    	user.save # Provide each user with authtoken
    end

  end

  def self.down
    remove_column :users, :authtoken
  end
end
