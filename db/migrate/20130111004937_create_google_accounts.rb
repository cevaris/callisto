class CreateGoogleAccounts < ActiveRecord::Migration
  def up
  	create_table :google_accounts do |t|
      t.integer :user_id

      t.string :access_token
      t.string :refresh_token
      t.string :expires_in
      t.string :issued_at

      t.timestamps
    end
  end

  def down
  	drop_table :google_accounts
  end
end
