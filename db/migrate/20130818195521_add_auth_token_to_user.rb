class AddAuthTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :authtoken, :text
  end

  def self.down
    remove_column :users, :authtoken
  end
end
