class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users, :force => true do |t|
      t.string   :name
      t.string   :email
      t.string   :password_digest
      t.string   :remember_token
      t.integer  :confirmed, :default => 0, :null => false
    end
  end
  def down
    drop_table :users
  end
end
